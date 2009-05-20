SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `crypted_password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `modules` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

insert into `accounts` values('1','Admin','User','info@lipsiasoft.com','7c3eff3ad1b7e8a076d3d537e774c30d54a64244','vshzwV+WzQE=\n','administrator',null,'2009-05-04 13:09:28','2009-05-18 08:24:31');

DROP TABLE IF EXISTS `attachments`;

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attached_file_name` varchar(255) DEFAULT NULL,
  `attached_content_type` varchar(255) DEFAULT NULL,
  `attached_file_size` int(11) DEFAULT NULL,
  `attacher_id` int(11) DEFAULT NULL,
  `attacher_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=700 DEFAULT CHARSET=utf8;

insert into `attachments` values('686','dashboard.jpg','image/jpeg','116446','1','Account','2009-05-17 10:47:22','2009-05-17 10:47:22'),
 ('687','dashboard-tm.jpg','image/jpeg','41716','1','Account','2009-05-17 10:47:35','2009-05-17 10:47:35'),
 ('688','posts.jpg','image/jpeg','120743','1','Account','2009-05-17 10:48:46','2009-05-17 10:48:46'),
 ('689','posts-tm.jpg','image/jpeg','43074','1','Account','2009-05-17 10:48:48','2009-05-17 10:48:48'),
 ('690','post-lists.jpg','image/jpeg','121139','1','Account','2009-05-17 10:49:54','2009-05-17 10:49:54'),
 ('691','post-lists-tm.jpg','image/jpeg','43112','1','Account','2009-05-17 10:49:57','2009-05-17 10:49:57'),
 ('692','richtexteditor.jpg','image/jpeg','133893','1','Account','2009-05-17 10:51:01','2009-05-17 10:51:01'),
 ('693','richtexteditor-tm.jpg','image/jpeg','46691','1','Account','2009-05-17 10:51:03','2009-05-17 10:51:03'),
 ('694','attachments.jpg','image/jpeg','125537','1','Account','2009-05-17 10:52:36','2009-05-17 10:52:36'),
 ('695','attachments-tm.jpg','image/jpeg','46826','1','Account','2009-05-17 10:52:38','2009-05-17 10:52:38'),
 ('696','categories.jpg','image/jpeg','142118','1','Account','2009-05-17 10:53:32','2009-05-17 10:53:32'),
 ('697','categories-tm.jpg','image/jpeg','49977','1','Account','2009-05-17 10:53:35','2009-05-17 10:53:35'),
 ('698','preview-attachments.jpg','image/jpeg','108140','1','Account','2009-05-17 10:54:14','2009-05-17 10:54:14'),
 ('699','preview-attachments-tm.jpg','image/jpeg','40390','1','Account','2009-05-17 10:54:16','2009-05-17 10:54:16');

DROP TABLE IF EXISTS `boxes`;

CREATE TABLE `boxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `position` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

insert into `boxes` values('3','Links','<ul><li><a href=\"http://groups.google.com/group/lipsiadmin\" target=\"_blank\">Google Group</a></li><li><a href=\"http://twitter.com/daddye\" target=\"_blank\">Twitter</a></li><li><a href=\"http://github.com/Lipsiasoft/lipsiadmin/tree/master\" target=\"_blank\">Source Code</a></li><li><a href=\"http://www.linkedin.com/in/lipsiasoft\" target=\"_blank\">Linkedin</a></li></ul>','0');

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `posts_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

insert into `categories` values('17','Tips & Tricks','2009-05-15 09:49:43','2009-05-15 09:49:43','0'),
 ('18','News','2009-05-15 09:49:52','2009-05-17 10:51:17','3'),
 ('19','How To','2009-05-15 09:50:52','2009-05-15 09:50:52','0'),
 ('20','Press','2009-05-15 09:51:08','2009-05-15 09:51:08','0');

DROP TABLE IF EXISTS `categories_posts`;

CREATE TABLE `categories_posts` (
  `category_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into `categories_posts` values('12','4'),
 ('10','4'),
 ('11','4'),
 ('14','10'),
 ('15','10'),
 ('5','19'),
 ('10','35'),
 ('12','37'),
 ('14','37'),
 ('13','37'),
 ('10','52'),
 ('16','52'),
 ('18','85'),
 ('18','91'),
 ('18','93');

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text,
  `ip` varchar(255) DEFAULT NULL,
  `spam` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12336 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description_short` text,
  `description_long` text,
  `tags` varchar(255) DEFAULT NULL,
  `menu` int(11) DEFAULT '0',
  `position` int(11) DEFAULT '0',
  `commentable` tinyint(1) DEFAULT '1',
  `draft` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `comments_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

insert into `posts` values('85','1','Official Site Lunched','Dear people,<div><br></div><div>we are pleased to announce our official web site.</div><div><br></div><div>Most people ask for it and we do it!</div><div><br></div><div>Many docs are on <a href=\"http://wiki.github.com/Lipsiasoft/lipsiadmin\">github wiki</a>&nbsp;and in future we imporve it here with a lot of tutorials, tips and triks and yes tutorials!</div>',null,'Lipsiadmin, Rails, Ruby','0','0','1','0','2009-05-15 09:54:37','2009-05-15 09:54:37','0'),
 ('86','1','What is it?','<b>Lipsiadmin</b> is a new revolutionary admin for your projects.<div><br></div><div>Is developped by <a href=\"http://www.lipsiasoft.com\">LipsiaSoft s.r.l.</a> that use it from 3 years in production enviroments.</div><div><br></div><div><b>Lipsiadmin</b> is based on <a href=\"http://extjs.com/\">Ext JS 2.2</a> framework (with prototype adapter) works perfectly with Rails 2+</div><div><br></div><div>This admin is studied for newbie developper but also for experts, is not entirely written in javascript \r\nbecause the aim of developper wose build in a agile way web/site apps so we use extjs in a new \r\nintelligent way a mixin of old&nbsp;html and new ajax functions, \r\nfor example ext manage the layout of page, grids, tree and errors, but form are in html code.</div>',null,'What is is Lipsiadmin','2','0','0','0','2009-05-15 09:58:32','2009-05-15 10:10:28','0'),
 ('87','1','Screenshots','<p><span style=\"font-size: 18px; font-weight: bold; \">Support request</span></p>\r\n<p class=\"center\" style=\"text-align:center\"><a href=\"http://farm4.static.flickr.com/3590/3309008976_b54225b557_o.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://farm4.static.flickr.com/3590/3309008976_a718c4a7e9.jpg\" width=\"500\" height=\"284\" alt=\"3309008976_a718c4a7e9.jpg\"></a></p>\r\n<p>Your customer can contact you from your admin in a simple way!</p>\r\n<p><span style=\"font-size: 18px; font-weight: bold; \">Reuse yours forms</span></p>\r\n<p class=\"center\" style=\"text-align:center\"><a href=\"http://farm4.static.flickr.com/3536/3308179667_fa21803ac2_o.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://farm4.static.flickr.com/3536/3308179667_a7b08d95d2.jpg\" width=\"500\" height=\"284\" alt=\"3308179667_a7b08d95d2.jpg\"></a></p>\r\n<p>With our helper <i>open_form</i> you can reuse your forms (new/edit) every where!</p>\r\n<p><span style=\"font-size: 18px; font-weight: bold; \">Reuse yours grids</span></p>\r\n<p class=\"center\" style=\"text-align:center\"><a href=\"http://farm4.static.flickr.com/3609/3309009186_09f7dd6a09_o.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://farm4.static.flickr.com/3609/3309009186_6624f644da.jpg\" width=\"500\" height=\"284\" alt=\"3309009186_6624f644da.jpg\"></a></p>\r\n<p>With our helper&nbsp;<i>open_grid</i>&nbsp;you can reuse your grids every where and manage selected records!</p>\r\n<p><span style=\"font-size: 18px; font-weight: bold; \">Any can customize their own grid</p>\r\n<p class=\"center\" style=\"text-align:center\"><a href=\"http://farm4.static.flickr.com/3467/3309009258_76e18536b2_o.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://farm4.static.flickr.com/3467/3309009258_1504aac711.jpg\" alt=\"\" width=\"500\" height=\"284\"></a></p>\r\n<p>Any can personalize columns width columns to show columns to hide, this data can be saved in cookies or in database.</p>\r\n<p><span style=\"font-size: 18px; font-weight: bold; \">Menu like Os</span></p>\r\n<p class=\"center\" style=\"text-align:center\"><a href=\"http://farm4.static.flickr.com/3444/3309009328_2969626cdd_o.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://farm4.static.flickr.com/3444/3309009328_08cf96b7c3.jpg\" width=\"500\" height=\"284\" alt=\"3309009328_08cf96b7c3.jpg\"></a></p>\r\n<p>Whit this menu you have a bigger area for &nbsp;your forms and grids</p>\r\n',null,'screens of lipsiadmin','2','0','0','0','2009-05-15 10:09:24','2009-05-15 10:17:51','0'),
 ('88','1','Work with us','<p>Do you want work with us? Really? Is dead simple!</p><p>Go to <a href=\"http://github.com/Lipsiasoft/lipsiadmin\">lipsiadmin</a> and click the <b>fork</b> button.</p>\n<pre><code>\n  git clone git://github.com/Lipsiasoft/lipsiadmin.git\n  cd lipsiadmin\n</code></pre>\n<p>Now make your changes</p>\n<pre><code>\n  git status\n  git commit -a\n  git push\n</code></pre>\n<p><a href=\"http://github.com/Lipsiasoft/lipsiadmin/forkqueue\" target=\"_blank\">go back to git hub</a> and click the <b>pull request</b> button.</p>\n<p>I\'m guessing that by now this is really clear.</p>','','work with us, lipsiadmin, ruby, rails','1','0',null,'0','2009-05-15 10:31:00','2009-05-17 10:26:00','0'),
 ('89','1','Where we are','<p style=\"text-align: center;\">\r\n<iframe width=\"710\" height=\"350\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"http://maps.google.it/maps?f=q&amp;source=s_q&amp;hl=it&amp;geocode=&amp;q=Tradate,+via+damiano+chiesa,+15&amp;ie=UTF8&amp;ll=45.740274,8.895493&amp;spn=0.020966,0.06094&amp;z=14&amp;iwloc=A&amp;output=embed\"></iframe>\r\n</p>',null,'where LipsiaSoft is localized?','1','0','0','0','2009-05-15 10:33:06','2009-05-15 10:33:27','0'),
 ('90','1','Suggestion?','<div>We build Lipsiadmin for simplify our work because we develop a lot of site, but<font face=\"\'Lucida Grande\'\" size=\"3\"><span style=\"border-collapse: collapse; font-size: 11px; white-space: pre; -webkit-border-horizontal-spacing: 2px; -webkit-border-vertical-spacing: 2px;\">&nbsp;<span style=\"border-collapse: separate; font-family: tahoma; font-size: 12px; white-space: normal; -webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: 0px; \">probability you have a better way o a suggestion to tell us, so tell us with:</span></span></font></div><div><br></div><div><ul><li><a href=\"/contact\">our form</a></li><li><a href=\"http://groups.google.com/group/lipsiadmin\">our forum</a></li></ul></div>',null,'Do you have a good suggestion?','1','0','0','0','2009-05-15 10:37:15','2009-05-15 10:37:55','0'),
 ('91','1','Lipsiadmin 4.1. Released','<p>We announce the new release of <b>Lipsiadmin</b>.</p>\n<p>This version finalize the 100% of localization/translation of the backend.</p>\n<p>So what\'s new?</p>\n<p>\n  Basically now backend_page and controllers can be untouched, because <b>Lipsiadmin </b>try to translate them using your locale, so if you aren\'t an english man for \n  localize  controller/forms/grids you need only to translate your <i>yml</i>file (located config/app/models).\n</p>\n\n','\n<p>Now we have for backend improved/added some new helpers.</p>\n\n<h1>Tab</h1> now try to translate itself \n<pre><code>\n# Look for: I18n.t(\"backend.tabs.settings\", :default => \"Settings\")\ntab :settings do\n</code></pre>\n\n<h1>Title</h1> try to do the same thing\n<pre><code>\n# Look for: I18n.t(\"backend.titles.welcome_here\", :default => \"Welcome Here\")\ntitle :welcome_here\n</code></pre>\n\nIn grid title you don\'t necessary translate \"List all #{model}\" in your locale or in your different english.\n\n<pre><code>\n# Look for: I18n.t(\"backend.general.list\", ...)\n# Generate: List all Accounts\nlist_title_for(Account)\n\n# Generate: List all My Accounts\nlist_title_for(\"My Accounts\")\n</code></pre>\n\nFinally we build some new helpers:\n\n<pre><code>\n# Generate: Edit Account 18\nedit_title_for(Account, @account.id)\n\n# Generate: Edit My Account Foo Bar\nedit_title_for(\"My Account\", @account.full_name)\n\n# Generate: New Account\nnew_title_for(Account)\n\n# Generate: New My Account\nnew_title_for(\"My Account\")\n\n# Generate: I18n.t(\"backend.labels.add\", :default => \"Add\")\ntl(\"Add\")\n\n# Generate: I18n.t(\"backend.labels.lipsiadmin_is_beautifull\", :default => \"Lipsiadmin is beautifull\")\ntt(\"Lipsiadmin is beautifull\")\n</code></pre>\n\nAt the end now we don want to call directly the name of an attribute so we provide a new helper\n<pre><code>\n# In config/locales/backend/models/en.yml\nen:\n  activerecord:\n    attributes:\n      account:\n        name: \"Account Name\"\n        suranme: \"Custom Title For Surname\"\n        role: \"Im a\"\n\n# Generates: \n#   Account Name\n#   Custom Title For Surname\n#   Im a\n#   Attribute not translated\nhuman_name_for :account, :name\nhuman_name_for :account, :surname\nhuman_name_for :account, :role\nhuman_name_for :account, :attribute_not_translated\n</code></pre>','Lipsiadmin, Rails, Ruby, Admin','0','0',null,'0','2009-05-15 14:41:07','2009-05-16 10:59:14','0'),
 ('92','1','Install','<p>\n  For install <b>Lipsiadmin</b> you can get it from \n  <a href=\"http://rubyforge.org/projects/lipsiadmin/\" target=\"_blank\">gems</a> \n  or by \n  <a href=\"http://github.com/Lipsiasoft/lipsiadmin\" target=\"_blank\">sourcecode</a>.\n</p>\n\n<h1>For use it with gem</h1>\n\n<pre><code>\n$ rails myapp\n$ sudo gem install lipsiadmin\n</code></pre>\n\n<p>Now edit myapp/config/environment.rb and add</p>\n<pre><code>\nconfig.gem \"lipsiadmin\", :version => \"< 5.0\"\n</code></pre>\n  \n<p>Why we need to specify version?</p>\n\n<p>\n  Simply because we mantain backward compatibility until a 5.0 version.\n  This mean that before v 5.0 we only do small improvemets, bug fix, doc etc...\n</p>\n\n\n<h1>Using source code</h1>\n\n<pre><code>\nscript/plugin install git://github.com/Lipsiasoft/lipsiadmin.git\n</code></pre>\n\n<h1>And now?</h1>  \n<p>now run script/generate and you can see some like:</p>\n\n<pre><code>\nInstalled Generators\n  Builtin: controller, integration_test, mailer, migration, model, etc..\n  Lipsiadmin: attachment, backend, backend_page, pdf, loops\n</code></pre>\n\n<p>So you can do:</p>\n<pre><code>\n$ script/generate backend                # Generate the base admin\n$ script/generate backend_page yourmodel # Generate a \"scaffold\" for your model\n$ script/generate state_session          # Create a \"scaffold\" for store extjs grid settings in db\n$ script/generate loops                  # Generate background workers\n$ script/generate frontend               # Generate the base frontend\n$ script/generate attachment             # Generate the an attachments\n$ script/generate pdf PdfName            # Generate a new pdf document\n</code></pre>','','how to install lipsiadmin, lipsiadmin, rails, ruby, backend','2','0','0','0','2009-05-16 10:20:53','2009-05-17 10:22:41','0'),
 ('93','1','What\'s next?','<p>In the next few days we want to release the source code of this blogging system that we called <b>LipsiaBlog</b></p>\n<p>We think that is a good way for know all fautures of <b>Lipsiadmin</b></p>\n<p>It\'s not complex like WordPress but I think is better than typo or mephisto because is much <b>lightweight</b>, <b>simple</b>, <b>fast</b>, <b>easy</b></p>\n<p>We focus to this fatures:</p>\n<ul>\n  <li>Blogger, MovableType, Metaweblog apis</li>\n\n  <li>Custom spam filter, we don\'t want to use akismet &amp; c because sucks!</li>\n\n  <li>Content Managment, like other blogging system we can manage quickly \"static\" pages</li>\n\n  <li>Quick comments editor. Thanks to Editable Grids we can quickly manage spam comments &amp; c.</li>\n\n  <li>Manage side boxes</li>\n</ul>\n<p>We provide some screenshots that are more than words</p>\n\n','\n<h1>Dashboard</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/686_dashboard.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/687_dashboard-tm.jpg\" width=\"480\" height=\"285\" alt=\"Dashboard\" /></a>\n</div>\n<h1>Post and static contents</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/688_posts.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/689_posts-tm.jpg\" width=\"480\" height=\"285\" alt=\"Posts and static contents\" /></a>\n</div>\n<h1>List of posts</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/690_post-lists.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/691_post-lists-tm.jpg\" width=\"480\" height=\"285\" alt=\"List of posts\" /></a>\n</div>\n<h1>Rich text editor</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/692_richtexteditor.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/693_richtexteditor-tm.jpg\" width=\"480\" height=\"285\" alt=\"Rich text editor\" /></a>\n</div>\n<h1>Attachments</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/694_attachments.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/695_attachments-tm.jpg\" width=\"480\" height=\"285\" alt=\"List of attachments\" /></a>\n</div>\n<h1>Categories</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/696_categories.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/697_categories-tm.jpg\" width=\"480\" height=\"285\" alt=\"Categories\" /></a>\n</div>\n<h1>Attachment Preview</h1>\n<div style=\"text-align: center;\">\n  <a href=\"http://lipsiadmin.com/uploads/698_preview-attachments.jpg\" rel=\"lightbox\" target=\"_blank\"><img src=\"http://lipsiadmin.com/uploads/699_preview-attachments-tm.jpg\" width=\"480\" height=\"285\" alt=\"Attachment Preview\" /></a>\n</div>','lipsiadmin, plannings','0','0',null,'0','2009-05-17 10:41:53','2009-05-17 11:01:14','0');

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into `schema_migrations` values('1'),
 ('10'),
 ('2'),
 ('3'),
 ('4'),
 ('5'),
 ('6'),
 ('7'),
 ('8'),
 ('9');

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `suffix` varchar(255) DEFAULT NULL,
  `menus` int(11) DEFAULT '1',
  `page_limit` int(11) DEFAULT '5',
  `feed_limit` int(11) DEFAULT '15',
  `feed_complete` tinyint(1) DEFAULT '0',
  `comments` tinyint(1) DEFAULT '1',
  `moderate_comments` tinyint(1) DEFAULT '1',
  `spam_black_list` text,
  `spam_max_links` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

insert into `settings` values('1','Lipsiablog','http://localhost:3000','info@lipsiasoft.com','- Lipsiablog','2','5','15','1','1','0','-online 4u 4-u acne adipex advicer baccarrat blackjack bllogspot booker buy byob carisoprodol casino chatroom cialis coolhu credit-card-debt cwas cyclen cyclobenzaprine day-trading debt-consolidation discreetordering duty-free dutyfree equityloans fioricet freenet shipping gambling- hair-loss homefinance holdem incest jrcreations leethal levitra macinstruct mortgagequotes nemogs online-gambling ottawavalleyag ownsthis paxil penis pharmacy phentermine poker poze pussy ringtones roulette shemale shoes -site slot-machine thorcarlson tramadol trim-spa ultram valeofglamorganconservatives viagra vioxx xanax zolus','3');

DROP TABLE IF EXISTS `state_sessions`;

CREATE TABLE `state_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `component` varchar(255) NOT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `index_state_sessions_on_component` (`component`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

insert into `state_sessions` values('1','1','ys-grid-boxes','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Achecker%25255Ewidth%25253Dn%2525253A20%255Eo%25253Aid%25253Dn%2525253A13%25255Ewidth%25253Dn%2525253A901%255Eo%25253Aid%25253Dn%2525253A14%25255Ewidth%25253Dn%2525253A289%5Esort%3Do%253Afield%253Ds%25253Aboxes.position%255Edirection%253Ds%25253ADESC'),
 ('2','1','ys-grid-categories','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Achecker%25255Ewidth%25253Dn%2525253A20%255Eo%25253Aid%25253Dn%2525253A1%25255Ewidth%25253Dn%2525253A655%255Eo%25253Aid%25253Dn%2525253A2%25255Ewidth%25253Dn%2525253A106%255Eo%25253Aid%25253Dn%2525253A3%25255Ewidth%25253Dn%2525253A214%255Eo%25253Aid%25253Dn%2525253A4%25255Ewidth%25253Dn%2525253A214%5Esort%3Do%253Afield%253Ds%25253Acategories.created_at%255Edirection%253Ds%25253ADESC'),
 ('3','1','ys-grid-posts','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Achecker%25255Ewidth%25253Dn%2525253A20%255Eo%25253Aid%25253Dn%2525253A1%25255Ewidth%25253Dn%2525253A465%255Eo%25253Aid%25253Dn%2525253A2%25255Ewidth%25253Dn%2525253A201%255Eo%25253Aid%25253Dn%2525253A3%25255Ewidth%25253Dn%2525253A61%255Eo%25253Aid%25253Dn%2525253A4%25255Ewidth%25253Dn%2525253A64%255Eo%25253Aid%25253Dn%2525253A5%25255Ewidth%25253Dn%2525253A77%255Eo%25253Aid%25253Dn%2525253A6%25255Ewidth%25253Dn%2525253A59%255Eo%25253Aid%25253Dn%2525253A7%25255Ewidth%25253Dn%2525253A107%255Eo%25253Aid%25253Dn%2525253A8%25255Ewidth%25253Dn%2525253A109%5Esort%3Do%253Afield%253Ds%25253Aposts.created_at%255Edirection%253Ds%25253ADESC');

SET FOREIGN_KEY_CHECKS = 1;
