Ext.ns('LipsiaSoft');

LipsiaSoft.Lightbox = (function(){
  var els = {},
    images = [],
    activeImage,
    initialized = false,
    selectors = [];

  return {
    overlayOpacity: 0.50,
    animate: true,
    resizeSpeed: 8,

    init: function() {
      this.resizeDuration = this.animate ? ((11 - this.resizeSpeed) * 0.15) : 0;
      this.overlayDuration = this.animate ? 0.2 : 0;

      if(!initialized) {
        Ext.apply(this, Ext.util.Observable.prototype);
        Ext.util.Observable.constructor.call(this);
        this.addEvents('open', 'close');
        this.initMarkup();
        this.initEvents();
        initialized = true;
      }
      this.register('a[rel^=lightbox]');
    },

    initMarkup: function() {
      els.shim = Ext.DomHelper.append(document.body, {
        tag: 'div',
        id: 'lps-lightbox-shim'
      }, true);
      
      els.overlay = Ext.DomHelper.append(document.body, {
        id: 'lps-lightbox-overlay'
      }, true);
      
      var lightboxTpl = new Ext.Template(this.getTemplate());
      els.lightbox = lightboxTpl.append(document.body, {}, true);

      var ids = 'outerImageContainer imageContainer image loading loadingLink'

      Ext.each(ids.split(' '), function(id){
        els[id] = Ext.get('lps-lightbox-' + id);
      });

      els.overlay.visibilityMode = els.lightbox.visibilityMode = els.shim.visibilityMode = Ext.Element.DISPLAY;

      els.overlay.hide();
      els.shim.hide();
      els.lightbox.hide();

      var size = (this.animate ? 250 : 1) + 'px';
      els.outerImageContainer.setStyle({
        width: size,
        height: size
      });
    },

    getTemplate : function() {
      return [
        '<div id="lps-lightbox">',
          '<div id="lps-lightbox-outerImageContainer">',
            '<div id="lps-lightbox-imageContainer">',
              '<img id="lps-lightbox-image">',
              '<div id="lps-lightbox-loading">',
                '<a id="lps-lightbox-loadingLink"></a>',
              '</div>',
            '</div>',
          '</div>',
        '</div>'
      ];
    },

    initEvents: function() {
      var close = function(ev) {
        ev.preventDefault();
        this.close();
      };

      els.overlay.on('click', close, this);
      els.loadingLink.on('click', close, this);
      els.image.on('click', close, this);

      els.lightbox.on('click', function(ev) {
        if(ev.getTarget().id == 'lps-lightbox') {
          this.close();
        }
      }, this);
    },

    register: function(sel, group) {
      if(selectors.indexOf(sel) === -1) {
        selectors.push(sel);

        Ext.fly(document).on('click', function(ev){
          var target = ev.getTarget(sel);

          if (target) {
            ev.preventDefault();
            this.open(target, sel, group);
          }
        }, this);
      }
    },

    open: function(image, sel, group) {
      group = group || false;

      var viewSize = this.getViewSize();
      els.overlay.setStyle({
        height: viewSize[1] + 'px'
      });
      
      els.shim.setStyle({
        height: viewSize[1] + 'px'
      }).show();

      els.overlay.fadeIn({
        duration: this.overlayDuration,
        endOpacity: this.overlayOpacity,
        callback: function() {
          images = [];

          var index = 0;
          if(!group) {
            images.push([image.href, image.title]);
          }
          else {
            var setItems = Ext.query(sel);
            Ext.each(setItems, function(item) {
              if(item.href) {
                images.push([item.href, item.title]);
              }
            });

            while (images[index][0] != image.href) {
              index++;
            }
          }

          // calculate top and left offset for the lightbox
          var pageScroll = Ext.fly(document).getScroll();
          var lightboxTop = pageScroll.top + (Ext.lib.Dom.getViewportHeight() / 2) - (250 / 2);
          var lightboxLeft = pageScroll.left;
          els.lightbox.setStyle({
            top: lightboxTop + 'px',
            left: lightboxLeft + 'px'
          }).show();

          this.setImage(index);
          
          this.fireEvent('open', images[index]);                    
        },
        scope: this
      });
    },

    setImage: function(index){
      activeImage = index;
            
      if (this.animate) {
        els.loading.show();
      }

      els.image.hide();
      
      var preload = new Image();
      preload.onload = (function(){
        els.image.dom.src = images[activeImage][0];
        this.resizeImage(preload.width, preload.height);
      }).createDelegate(this);
      preload.src = images[activeImage][0];
    },

    resizeImage: function(w, h){
      var wCur = els.outerImageContainer.getWidth();
      var hCur = els.outerImageContainer.getHeight();
      
      var wVp = Ext.lib.Dom.getViewportWidth();
      var hVp = Ext.lib.Dom.getViewportHeight();
      
      var hNew = (h > hVp) ? (hVp-20) : h;

      els.image.setStyle({ height: hNew - 20 + 'px' });
      var wImg = els.image.getWidth();
      var wNew = wImg+20;

      var wDiff = wCur - wNew;
      var hDiff = hCur - hNew;

      var queueLength = 0;
      
      // calculate new top
      var pageScroll = Ext.fly(document).getScroll();
      var lightboxTop = pageScroll.top + (Ext.lib.Dom.getViewportHeight() / 2) - (hNew / 2);

      if (hDiff != 0 || wDiff != 0) {
        els.outerImageContainer.syncFx()
          .shift({
            height: hNew,
            duration: this.resizeDuration
          })
          .shift({
            width: wNew,
            duration: this.resizeDuration
          })
          .shift({
            y: lightboxTop,
            duration: this.resizeDuration
          });
        queueLength++;
      }

      var timeout = 0;
      if ((hDiff == 0) && (wDiff == 0)) {
        timeout = (Ext.isIE) ? 250 : 100;
      }

      (function(){
        this.showImage();
      }).createDelegate(this).defer((this.resizeDuration*1000) + timeout);
    },

    showImage: function(){
      els.loading.hide();
      els.image.fadeIn({
        duration: this.resizeDuration,
        scope: this
      });
    },

    close: function(){
      els.lightbox.hide();
      els.overlay.fadeOut({
        duration: this.overlayDuration
      });
      els.shim.hide();
      this.fireEvent('close', activeImage);
    },

    getViewSize: function() {
      return [Ext.lib.Dom.getViewWidth(true), Ext.lib.Dom.getViewHeight(true)];
    }
  }
})();

Ext.onReady(LipsiaSoft.Lightbox.init, LipsiaSoft.Lightbox);