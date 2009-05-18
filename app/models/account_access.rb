class AccountAccess < Lipsiadmin::AccessControl::Base 

  roles_for :administrator do |role|
    # Shared Permission
    role.allow_all_actions "/backend"
    role.allow_all_actions "/backend/base"
    role.allow_all_actions "/backend/state_sessions"
    
    role.project_module :account do |project|
      project.menu :list,   "/backend/accounts.js" do |submenu|
        submenu.add :new, "/backend/accounts/new"
      end
    end
    
    role.project_module :contents do |project|
      Setting.menu_range.each do |i|
        name = i == 0 ? :list_articles : I18n.t("backend.menus.list_in_menu", :i => i)
        project.menu name,   "/backend/posts/#{i}.js" do |submenu|
          submenu.add :new, "/backend/posts/new/#{i}"
        end
      end
    end     

    role.project_module :files do |project|
      project.menu :list,   "/backend/attachments.js" do |submenu|
        submenu.add :new, "/backend/attachments/new"
      end
    end 

    role.project_module :comments do |project|
      project.menu :list,   "/backend/comments.js" do |submenu|
        submenu.add :new, "/backend/comments/new"
      end
    end 

    role.project_module :categories do |project|
      project.menu :list,   "/backend/categories.js" do |submenu|
        submenu.add :new, "/backend/categories/new"
      end
    end
    
    role.project_module :box do |project|
      project.menu :list,   "/backend/boxes.js" do |submenu|
        submenu.add :new, "/backend/boxes/new"
      end
    end 

    role.project_module :settings, "/backend/settings" do |project|
    end

    # Please don't remove this comment! It's used for auto adding project modules

  end
  
  
end