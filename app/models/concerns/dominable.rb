module Dominable
  extend ActiveSupport::Concern

  included do
    before_validation do
      set_dn_from_domain
    end
  end

  # Get domain of the object from the full subtree
  def domain
    # if domain_id is not defined, obtain it from object dn
    unless @domain || (object = self.dn) == nil?
      domain_dn = nil
      domain_prefix = Domain.prefix.to_s.downcase
      while parent_object = object.parent
        domain_dn = object.rdns[0] if parent_object.to_s.split(",").first.downcase == domain_prefix
        object = parent_object
      end
      if domain_dn
        domain_id = domain_dn[Domain.dn_attribute]
        @domain = Domain.find domain_id
      end
    end
    return @domain
  end
  # Set domain of the object and build dn
  def domain=domain
    @domain = domain if domain.class == Domain
  end
  # Set the dn of the object from the related domain
  def set_dn_from_domain
    self.dn = "#{self.class.dn_attribute}=#{self.id}," + parent_dn
  end

  # Get the parent distinguised name of the object
  def parent_dn
    # If there is no prefix on the model, objet is just below domain
    if self.class::PREFIX.blank?
      self.domain.dn.to_s
    # With a prefix in the model, it has to be in that place
    else
      self.class::PREFIX + "," + self.domain.dn.to_s
    end
  end
end
