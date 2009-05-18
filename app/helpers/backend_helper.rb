module BackendHelper
  
  
  def tab_editor(klass, method, name, options={})
    instance = instance_variable_get("@#{klass}")
    value    = instance.send(method).to_s
    js = <<-JS
      var tp = Backend.app.contentDynamic.items.get(0)
      var htmleditor = new Ext.form.HtmlEditor({ id:'htmleditor_#{klass}_#{method}', name: '#{klass}[#{method}]', enableFont: false, value: '#{escape_javascript(value)}' });
      tp.add({
        title: '#{I18n.t("backend.tabs.#{name.to_s.downcase}", :default => name.to_s.humanize)}',
        id: '#{klass}_#{method}',
        autoScroll: false,
        items: htmleditor
      });
      htmleditor.on('render', function(c){
        tb = c.getToolbar();
        tb.insertButton(14, {
          cls: 'x-btn-icon x-edit-image',
          tooltip: 'Aggiunge un immagine o un file',
          handler: function(){ 
            var win = new Backend.window({ url:'/backend/attachments.js', grid: 'gridPanel' });
            win.on('selected', function(grid, selections){
              selections.each(function(selected){
                if (selected.data['attachments.attached_content_type'].include('image')){
                  c.relayCmd('insertHTML', '<img src="'+selected.data['attachments.url']+'" />')
                } else {
                  c.relayCmd('insertHTML', '<a href="'+selected.data['attachments.url']+'">'+selected.data['attachments.attached_file_name']+'</a>');
                }
              });
            });
            win.show();
          },
          tabIndex: -10
        })
      });
    JS
    
    javascript_tag(js)
  end
  
end