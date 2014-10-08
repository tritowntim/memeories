require 'spec_helper'

describe Api::V1::MemesController do

  describe '#show' do

    let!(:meme)  { create :meme }

    before { get :show, id: meme.id }

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

    before { get :index }

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

    before { post :create, params }

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
            'id'          => meme.id.to_s,
            'name'        => name,
            'started_at'  => started_at.to_s,
            'emoji'       => emoji,
            'medium'      => medium,
            'description' => description
          }
    end

    before do
      put :update, id: meme.id, meme: params
    end

    it 'udpates existing meme' do
      actual = Meme.find(meme.id)
      expect(actual.name).to        eq name
      expect(actual.started_at).to  eq started_at
      expect(actual.emoji).to       eq emoji
      expect(actual.medium).to      eq medium
      expect(actual.description).to eq description
    end

  end

end
