require 'test_helper'

class ExamQuestionsControllerTest < ActionController::TestCase
  setup do
    @exam_question = exam_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exam_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exam_question" do
    assert_difference('ExamQuestion.count') do
      post :create, exam_question: { exam_id: @exam_question.exam_id, question: @exam_question.question }
    end

    assert_redirected_to exam_question_path(assigns(:exam_question))
  end

  test "should show exam_question" do
    get :show, id: @exam_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exam_question
    assert_response :success
  end

  test "should update exam_question" do
    put :update, id: @exam_question, exam_question: { exam_id: @exam_question.exam_id, question: @exam_question.question }
    assert_redirected_to exam_question_path(assigns(:exam_question))
  end

  test "should destroy exam_question" do
    assert_difference('ExamQuestion.count', -1) do
      delete :destroy, id: @exam_question
    end

    assert_redirected_to exam_questions_path
  end
end
