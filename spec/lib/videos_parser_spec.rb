# frozen_string_literal: true

require_relative '../../lib/videos_parser'

RSpec.describe VideosParser do
  describe '.parse' do
    subject { described_class.parse(filepath) }

    context 'when filepath doesnt exist' do
      let(:filepath) { 'fakepath.json' }

      before do
        allow(File).to receive(:exist?).with(filepath).and_return(false)
      end

      it 'raises an error' do
        expect { subject }.to raise_error("Unable to find #{filepath} file.")
      end
    end

    context 'when filepath exists' do
      let(:filepath) { 'realpath.json' }

      before do
        allow(File).to receive(:exist?).with(filepath).and_return(true)
        allow(File).to receive(:read).with(filepath).and_return(videos)
      end

      context 'when json is well-formatted' do
        let(:videos) do
          '[{
            "id": "-07UfcqbJxc",
            "views_count": 40,
            "topic_ids": ["/m/0cp0ad6"]
          }]'
        end

        it 'doesnt raise an error' do
          expect { subject }.not_to raise_error
        end

        it 'returns an array of videos' do
          expect(subject).to contain_exactly(
            'id' => '-07UfcqbJxc',
            'views_count' => 40,
            'topic_ids' => ['/m/0cp0ad6']
          )
        end
      end

      context 'when json is mal-formatted' do
        let(:videos) do
          '[{
            "id": "-07UfcqbJxc",
            "views_count": 40
            "topic_ids": ["/m/0cp0ad6"]
          }]'
        end

        it 'doesnt raise an error' do
          expect { subject }.not_to raise_error
        end

        it 'returns an empty array' do
          expect(subject).to be_empty
        end
      end
    end
  end
end
