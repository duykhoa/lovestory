class AssetsCleaning
  TIME = 3.hours

  def self.call
    Asset.delete_all([
      "post_id is NULL AND created_at <= :time", time: TIME.ago
    ])
  end
end
