require 'rails_helper'

describe Asset do
  it { should belong_to(:post) }
end
