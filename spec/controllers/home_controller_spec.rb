require 'spec_helper'

describe HomeController do

  describe '#index' do
    before { get :index }
    it { expect(response).to be_success }
    it { expect(response.body).to eq "" }
  end

end
