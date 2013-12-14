class Bundle < ActiveRecord::Base
  attr_accessible :bundle_pic, :name, :price, :course_ids, :active, :available

  has_and_belongs_to_many :courses

  has_and_belongs_to_many :users

  validates_presence_of :name, :price, :course_ids, :bundle_pic

  mount_uploader :bundle_pic, BundlePicUploader

  scope :active_and_available_bundles, -> { where("active = ? and available = ?", true, true) }
  scope :active_bundles, -> { where("active = ?", true) }

  after_save :create_or_update_bundle

  def activate
    update_attributes(:active => true, :available => true)
  end

  def purchased?(learner_id)
    learner = Learner.find_by_id(learner_id)
    learner.bundles.include?(self)
  end

  def teacher
    users.where(:type => 'Teacher').first
  end

  def learners
    users.where(:type => 'Learner').first
  end

  def download_link
    "/uploads/bundle/#{ name.gsub(/\s/, '_').downcase }.zip"
  end

  private

  def create_or_update_bundle
    root_dir = FileUtils.mkdir_p("#{ Rails.root }/public/uploads/bundle/")
    output_file = "#{ root_dir.first }/#{ name.gsub(/\s/, '_').downcase }.zip"

    if File.exists?(output_file)
      FileUtils.rm_f(output_file)
    end

    input_files = ""

    courses.with_sections.each do |course|
      course.sections.each do |section|
        input_files << " #{ section.attachment.root}#{section.attachment.url }"
      end
    end

    `zip -j #{ output_file } #{ input_files }`

    download_link
  end
end
