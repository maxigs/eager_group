require 'spec_helper'

RSpec.describe EagerGroup, type: :model do
  describe '.eager_group' do
    context 'has_many' do
      it 'gets Post#approved_comments_count' do
        posts = Post.all.eager_group(:approved_comments_count)
        expect(posts[0].approved_comments_count).to eq 1
        expect(posts[1].approved_comments_count).to eq 2
      end

      it 'gets Post#comments_average_rating' do
        posts = Post.all.eager_group(:comments_average_rating)
        expect(posts[0].comments_average_rating).to eq 3
        expect(posts[1].comments_average_rating).to eq 4
      end

      it 'gets both Post#approved_comments_count and Post#comments_average_rating' do
        posts = Post.all.eager_group(:approved_comments_count, :comments_average_rating)
        expect(posts[0].approved_comments_count).to eq 1
        expect(posts[0].comments_average_rating).to eq 3
        expect(posts[1].approved_comments_count).to eq 2
        expect(posts[1].comments_average_rating).to eq 4
        expect(posts[2].approved_comments_count).to eq 0
      end
    end

    context 'has_many :through' do
      it 'gets Teacher#students_count' do
        teachers = Teacher.all.eager_group(:students_count)
        expect(teachers[0].students_count).to eq 1
        expect(teachers[1].students_count).to eq 3
      end
    end
  end
end
