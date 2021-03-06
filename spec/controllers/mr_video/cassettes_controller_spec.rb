require 'rails_helper'

describe MrVideo::CassettesController do
  routes { MrVideo::Engine.routes }

  render_views

  before do
    allow(controller.main_app).to receive(:root_path).and_return '/'
  end

  describe '#index' do
    let(:index) { get(:index) }

    subject { index }

    before do
      index
    end

    it { should be_successful }
  end

  describe '#show' do
    let(:id) { MrVideo::IdService.encode('bell_house') }
    let(:params) { { id: id } }
    let(:show) { get(:show, params: params) }

    subject { show }

    before do
      show
    end

    it { should be_successful }
  end

  describe '#destroy' do
    let(:id) { MrVideo::IdService.encode('bell_house') }
    let(:cassette) { double(:cassette, id: id) }
    let(:params) { { id: id } }
    let(:destroy) { delete(:destroy, xhr: true, params: params) }

    subject { destroy }

    before do
      expect(MrVideo::Cassette).to receive(:find).with(id) { cassette }
      allow(cassette).to receive(:destroy)
      destroy
    end

    it { should be_successful }

    it 'should destroy the cassette' do
      expect(cassette).to have_received(:destroy)
    end
  end

end
