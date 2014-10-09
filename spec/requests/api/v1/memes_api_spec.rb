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
          'id'          => meme.id,
          'name'        => meme.name,
          'started_at'  => meme.started_at.to_s,
          'emoji'       => meme.emoji,
          'medium'      => meme.medium,
          'description' => meme.description
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
            'id'          => first_meme.id,
            'name'        => first_meme.name,
            'started_at'  => first_meme.started_at.to_s,
            'emoji'       => first_meme.emoji,
            'medium'      => first_meme.medium,
            'description' => first_meme.description
          },
          {
            'id'          => second_meme.id,
            'name'        => second_meme.name,
            'started_at'  => second_meme.started_at.to_s,
            'emoji'       => second_meme.emoji,
            'medium'      => second_meme.medium,
            'description' => second_meme.description
          }
        ]
      }
      expect(actual).to eq expected
    end
  end

  describe '#create' do
    let(:name)        { '#icecream' }
    let(:started_at)  { Date.yesterday }
    let(:emoji)       { false }
    let(:medium)      { 'offline' }
    let(:description) { 'ice cream runs' }

    let!(:params) do
      {
        'meme' =>
          {
            'name'        => name,
            'started_at'  => started_at.to_s,
            'emoji'       => emoji,
            'medium'      => medium,
            'description' => description
          }
      }
    end

    before { post api_v1_memes_path, params }

    it { expect(response).to be_success }

    it 'creates a new meme' do
      actual = Meme.last
      expect(actual.name).to        eq name
      expect(actual.started_at).to  eq started_at
      expect(actual.emoji).to       eq emoji
      expect(actual.medium).to      eq medium
      expect(actual.description).to eq description
    end

  end

  describe '#update' do
    let!(:meme)        { create :meme }
    let(:name)         { '#BizzaroKatie' }
    let(:started_at)   { 3.days.ago.beginning_of_day }
    let(:emoji)        { false }
    let(:medium)       { 'offline' }
    let(:description)  { 'Katie has a doppleganger' }

    let(:params) do
      {
        'meme' =>
          {
            'id'          => meme.id.to_s,
            'name'        => name,
            'started_at'  => started_at.to_s,
            'emoji'       => emoji,
            'medium'      => medium,
            'description' => description
          }
      }
    end

    before { put api_v1_meme_path(meme), params }

    it { expect(response).to be_success }

    it 'udpates existing meme' do
      actual = Meme.find(meme.id)
      expect(actual.name).to        eq name
      expect(actual.started_at).to  eq started_at
      expect(actual.emoji).to       eq emoji
      expect(actual.medium).to      eq medium
      expect(actual.description).to eq description
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
