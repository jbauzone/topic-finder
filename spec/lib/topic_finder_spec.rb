# frozen_string_literal: true

require_relative '../../lib/topic_finder'

RSpec.describe TopicFinder do
  describe '#with_max_views_count' do
    subject { described_class.new.with_max_views_count(videos) }

    context 'when there is no videos' do
      let(:videos) { [] }

      it 'retuns empty' do
        expect(subject).to be_empty
      end
    end

    context 'when there is missing topic_ids key' do
      let(:videos) do
        [{
          'id' => '-07UfcqbJxc',
          'views_count' => 40
        }, {
          'id' => '-2hQnCfG4Go',
          'views_count' => 22,
          'topic_ids' => ['/m/0cp0zz4']
        }]
      end

      it 'retuns the topic_id and the max views_count' do
        expect(subject).to contain_exactly('/m/0cp0zz4')
      end
    end

    context 'when there is missing views_count key' do
      let(:videos) do
        [{
          'id' => '--u7dYx9fWg',
          'views_count' => 22,
          'topic_ids' => ['/m/0kz2x1z', '/m/0146nb']
        }, {
          'id' => '-07UfcqbJxc',
          'topic_ids' => ['/m/0kz2x1z']
        }, {
          'id' => '-2hQnCfG4Go',
          'views_count' => 2780,
          'topic_ids' => ['/m/0cp0zz4']
        }]
      end

      it 'retuns the topic_id and the max views_count' do
        expect(subject).to contain_exactly('/m/0cp0zz4')
      end
    end

    context 'when there is videos' do
      let(:videos) do
        [{
          'id' => '--u7dYx9fWg',
          'views_count' => 22,
          'topic_ids' => ['/m/0kz2x1z', '/m/0146nb']
        }, {
          'id' => '-07UfcqbJxc',
          'views_count' => 2780,
          'topic_ids' => ['/m/0kz2x1z']
        }, {
          'id' => '-2hQnCfG4Go',
          'views_count' => 2780,
          'topic_ids' => ['/m/0cp0zz4']
        }]
      end

      it 'retuns the topic_id and the max views_count' do
        expect(subject).to contain_exactly('/m/0kz2x1z')
      end
    end

    context 'when there is multiple topic_ids with same max views_count' do
      let(:videos) do
        [{
          'id' => '--u7dYx9fWg',
          'views_count' => 22,
          'topic_ids' => ['/m/0kz2x1z', '/m/0146nb']
        }, {
          'id' => '-07UfcqbJxc',
          'views_count' => 2780,
          'topic_ids' => ['/m/0kz2x1z']
        }, {
          'id' => '-2hQnCfG4Go',
          'views_count' => 2802,
          'topic_ids' => ['/m/0cp0zz4']
        }]
      end

      it 'retuns all topic_ids and max views_count' do
        expect(subject).to contain_exactly('/m/0kz2x1z', '/m/0cp0zz4')
      end
    end
  end
end
