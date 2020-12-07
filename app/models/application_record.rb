class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  enum status:  { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}, _suffix: true
  enum making_status:  { 製作不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}, _suffix: true

  def view_PostalCode_and_Address_and_Name
    self.postal_code + self.address + self.name
  end

end
