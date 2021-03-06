class CreateServiceTeamMembers < ActiveRecord::Migration
  def change
    create_table :service_team_members do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.belongs_to :team_member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
