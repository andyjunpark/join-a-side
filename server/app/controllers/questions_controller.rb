class QuestionsController < ApplicationController

  def index
    category = Category.find params[:category_id]
    questionsWithVotes = []
    category.questions.each do |question|
      vote = question.vote
      user = question.user
 
      q = {
        id: question.id,
        title: question.title,
        answer_a: question.answer_a,
        answer_b: question.answer_b,
        category_id: question.category_id,
        user_id: question.user_id,
        created_at: question.created_at,
        vote_a: vote.vote_a,
        vote_b: vote.vote_b,
        first_name: user.first_name,
        last_name: user.last_name
      }
      questionsWithVotes = questionsWithVotes + [q]
    end
    
    render json: questionsWithVotes
  end

  def show
    question = Question.find params[:id]
    votes = question.vote
    user = question.user
    q = {
      id: question.id,
      title: question.title,
      answer_a: question.answer_a,
      answer_b: question.answer_b,
      category_id: question.category_id,
      user_id: question.user_id,
      created_at: question.created_at,
      vote_a: votes.vote_a,
      vote_b: votes.vote_b,
      first_name: user.first_name,
      last_name: user.last_name
    }

    render json: q  end

  def create
      question = Question.new(question_params)
      if question.save
        Vote.create(vote_a: 0, vote_b: 0, question_id: question.id )
        render json: @question
      else
        render json: @question.errors
      end
  end

  private 

  def question_params
    params.permit(
      :title,
      :answer_a,
      :answer_b,
      :category_id,
      :user_id
    )
  end

end
