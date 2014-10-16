require 'spec_helper'

describe 'Memes API' do

  describe '#show' do

    let!(:meme)  { create :meme }

    before { get api_v1_meme_path(meme) }

    it { expect(response).to be_success }

    it 'retrieves specified meme' do
      actual = JSON.parse(response.body)
      expected = {
        'meme' => {
          'id'            => meme.id,
          'name'          => meme.name,
          'funny'         => meme.funny,
          'emoji_pattern' => meme.emoji_pattern,
          'description'   => meme.description
        }
      }
      expect(actual).to eq expected
    end
  end

  describe '#index' do

    let!(:first_meme)  { create :meme }
    let!(:second_meme) { create :meme }

    before { get api_v1_memes_path }

    it { expect(response).to be_success }

    it 'retrieves all memes' do
      actual = JSON.parse(response.body)
      expected = {
        'memes' => [
          {
            'id'            => first_meme.id,
            'name'          => first_meme.name,
            'emoji_pattern' => first_meme.emoji_pattern,
            'funny'         => first_meme.funny,
            'description'   => first_meme.description
          },
          {
            'id'            => second_meme.id,
            'name'          => second_meme.name,
            'emoji_pattern' => second_meme.emoji_pattern,
            'funny'         => second_meme.funny,
            'description'   => second_meme.description
          }
        ]
      }
      expect(actual).to eq expected
    end
  end

  describe '#create' do
    let(:name)          { '#icecream' }
    let(:funny)         { false }
    let(:emoji_pattern) { ':ice_cream:' }
    let(:description)   { 'ice cream runs' }

    let!(:params) do
      {
        'meme' =>
          {
            'name'          => name,
            'emoji_pattern' => emoji_pattern,
            'funny'         => funny,
            'description'   => description
          }
      }
    end

    before { post api_v1_memes_path, params }

    it { expect(response).to be_success }

    it 'creates a new meme' do
      actual = Meme.last
      expect(actual.name).to          eq name
      expect(actual.funny).to         eq funny
      expect(actual.emoji_pattern).to eq emoji_pattern
      expect(actual.description).to   eq description
    end

  end

  describe '#update' do
    let!(:meme)         { create :meme }
    let(:name)          { 'NotKatie' }
    let(:emoji_pattern) { ':woman:' }
    let(:funny)         { false }
    let(:description)   { 'Katie has a doppleganger' }

    let(:params) do
      {
        'meme' =>
          {
            'id'            => meme.id.to_s,
            'name'          => name,
            'emoji_pattern' => emoji_pattern,
            'funny'         => funny,
            'description'   => description
          }
      }
    end

    before { put api_v1_meme_path(meme), params }

    it { expect(response).to be_success }

    it 'udpates existing meme' do
      actual = Meme.find(meme.id)
      expect(actual.name).to          eq name
      expect(actual.funny).to         eq funny
      expect(actual.emoji_pattern).to eq emoji_pattern
      expect(actual.description).to   eq description
    end

  end

  describe '#destroy' do
    let!(:meme) { create :meme }

    it { expect(response).to be_nil }

    it 'hard-deletes existing meme' do
      expect { delete api_v1_meme_path(meme.id) }.to change { Meme.count }.by(-1)
    end
  end

end
