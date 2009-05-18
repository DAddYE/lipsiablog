class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string  :name
      t.string  :website
      t.string  :email
      t.string  :suffix
      t.integer :menus,               :default => 1
      t.integer :page_limit,          :default => 5
      t.integer :feed_limit,          :default => 15
      t.boolean :feed_complete,       :default => false
      t.boolean :comments,            :default => true
      t.boolean :moderate_comments,   :default => true
      t.text    :spam_black_list
      t.integer :spam_max_links
    end
    
    # Basic Settings here:
    setting                 = Setting.new
    setting.name            = "LipsiaBlog"
    setting.website         = "http://localhost:3000"
    setting.email           = "info@lipsiasoft.com"
    setting.suffix          = "- LipsiaBlog"
    setting.menus           = 2
    setting.spam_black_list = "-online 4u 4-u acne adipex advicer baccarrat blackjack bllogspot booker buy byob carisoprodol casino chatroom cialis coolhu credit-card-debt cwas cyclen cyclobenzaprine day-trading debt-consolidation discreetordering duty-free dutyfree equityloans fioricet freenet shipping gambling- hair-loss homefinance holdem incest jrcreations leethal levitra macinstruct mortgagequotes nemogs online-gambling ottawavalleyag ownsthis paxil penis pharmacy phentermine poker poze pussy ringtones roulette shemale shoes -site slot-machine thorcarlson tramadol trim-spa ultram valeofglamorganconservatives viagra vioxx xanax zolus"
    setting.spam_max_links  = 3
    setting.save(false)
  end

  def self.down
    drop_table :settings
  end
end
