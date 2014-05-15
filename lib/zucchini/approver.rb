class Zucchini::Approver < Zucchini::Detector
  parameter "PATH", "a path to feature or a directory"

  option %W(-p --pending), :flag, "update pending screenshots instead"
  option %W(-f --failed), :flag, "update only failed/mismatched screenshots"


  def run_command
    reference_type = pending? ? "pending" : "reference"
    failed_option = failed?
    features.each do |f|
      f.device = @device
      f.approve reference_type, failed_option
    end
    features.inject(true){ |result, feature| result &= feature.succeeded }
  end
end
