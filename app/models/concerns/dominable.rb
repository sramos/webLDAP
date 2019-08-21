module Dominable
  extend ActiveSupport::Concern

  included do
    attr_writer :domain
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

  # Ge the parent distinguised name of the object
  def parent_dn
    self.class.prefix.to_s + "," + self.domain.dn.to_s
  end
end
