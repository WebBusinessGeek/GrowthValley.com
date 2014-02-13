class Bundle < ActiveRecord::Base
  attr_accessible :bundle_pic, :name, :price, :course_ids, :active, :available

  alias_attribute :title, :name
  alias_attribute :course_title, :name
  alias_attribute :amount, :price

  has_and_belongs_to_many :courses
  has_and_belongs_to_many :users
  has_many :transactions, as: :resource

  validates_presence_of :name, :price, :course_ids

  mount_uploader :bundle_pic, BundlePicUploader

  scope :active_and_available_bundles, -> { where("active = ? and available = ?", true, true) }
  scope :active_bundles, -> { where("active = ?", true) }

  after_save :create_or_update_bundle

  def activate
    update_attributes(:active => true, :available => true)
  end

  def purchased?(learner_id)
    learner = User.find_by_id(learner_id)
    learner.bundles.include?(self)
  end

  def teacher
    users.where(:type => 'Teacher').first
  end

  def learners
    users.where(:type => 'Learner').first
  end

  def download_link
    teacher_name = "first_teacher" # users.where(:type => 'Teacher').first.full_name.downcase.gsub(/\s/, '_')
    bundle_name = name.downcase.gsub(/\s/, '_')
    "/uploads/bundles/#{ teacher_name }/#{ bundle_name }.zip"
  end

  private

  def create_or_update_bundle
    teacher_name = "first_teacher" # users.where(:type => 'Teacher').first.full_name.downcase.gsub(/\s/, '_')
    bundle_name = name.downcase.gsub(/\s/, '_')
    root_dir = FileUtils.mkdir_p("#{ Rails.root }/public/uploads/bundles/#{ teacher_name }")

    courses.with_sections.each do |course|
      input_files = ""
      FileUtils.mkdir_p("#{ root_dir.first }/#{ bundle_name }")
      output_file = "#{ root_dir.first }/#{ bundle_name }/#{ course.title.downcase.gsub(/\s/, '_') }.zip"

      if File.exists?(output_file)
        FileUtils.rm_f(output_file)
      end

      course.sections.each do |section|
        input_files << " #{ section.attachment.root}#{section.attachment.url }"
      end

      `zip -j #{ output_file } #{ input_files }`
    end

    `zip -j #{ root_dir.first }/#{ bundle_name }.zip #{ root_dir.first }/#{ bundle_name }/*zip`

    if File.exists?("#{ root_dir.first }/#{ bundle_name }.zip")
      FileUtils.rm_rf("#{ root_dir.first }/#{ bundle_name }/")
    end

    download_link
  end
end
