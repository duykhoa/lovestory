class PolymerElement
  def path
    development? && !test_build? ? development_path : dist_path
  end

  private

  def development?
    Rails.env.development?
  end

  def test_build?
    ENV['BUILD']
  end

  def development_path
    "../components"
  end

  def dist_path
    "../dist"
  end
end

ELEMENT_PATH = PolymerElement.new.path
