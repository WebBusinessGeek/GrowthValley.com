class Pl::ContentsController < ApplicationController
  def new
    @lesson = Pl::Lesson.find(params[:lesson_id])
    build_content
  end

  def create
    @lesson = Pl::Lesson.find(params[:lesson_id])
    build_content
    if @content.save
      redirect_to lesson_path(@content.lesson)
    else
      render :new
    end
  end

  def edit
    @content = Pl::Content.find(params[:id])
  end

  def update
    @content = Pl::Content.find(params[:id])
    @content.update_attributes(params[:content])
    if @content.save
      redirect_to lesson_path(@content.lesson)
    else
      render :edit
    end
  end

  def destroy
    @content = Pl::Content.find(params[:id])
    @content.destroy
  end

  private

  def build_content
    @content = Pl::Content.new(title: params[:content][:title])
    puts teachable_params
    @content.build_teachable(type, teachable_params)
    @content.lesson = @lesson
  end

  def type
    params[:content][:teachable_type]
  end

  def teachable_params
    if teachable_attributes = params[:content][:teachable_attributes]
      teachable_attributes
    else
      {}
    end
  end
end