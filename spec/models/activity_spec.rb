require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { should belong_to(:user) }
end
