class UsersController < ApplicationController
  def list_subjects
    @subjects = Subject.all
  end

  def update_user_subjects
    if params[:user].present? && params[:user][:subject_ids].present?
      if params[:user][:subject_ids].length > 3 || current_user.subjects.count == 3
        redirect_to user_subjects_path, alert: 'Maximum 3 subjects can be added...'
      else
        params[:user][:subject_ids].collect do |subj|
          s = Subject.find_by_id(subj)
          current_user.subjects.push(s) unless current_user.subjects.include?(s)
        end
        redirect_to courses_path, notice: 'Subjects added successfully!'
      end
    else
      redirect_to user_subjects_path, alert: 'You must subscribe to atleast one subject...'
    end
  end
end
