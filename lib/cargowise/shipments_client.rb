# coding: utf-8

module Cargowise

  # SOAP client for retreiving shipment data. Not much to
  # see here, used by the Shipment resource class.
  #
  class ShipmentsClient < AbstractClient # :nodoc:

    # return an array of shipments. Each shipment should correspond to
    # a consolidated shipment from the freight company.
    #
    # filter_hash should be a hash that will be serialised into an
    # XML fragment specifying the search criteria. See the WSDL documentation
    # for samples
    #
    def get_shipments_list(company_code, username, pass, filter_hash)
      soap_action = 'http://www.edi.com.au/EnterpriseService/GetShipmentsList'
      soap_headers = headers(company_code, username, pass)
      response = invoke('tns:GetShipmentsList', :soap_action => soap_action, :soap_header => soap_headers, :soap_body => filter_hash)
      response.document.xpath("//tns:GetShipmentsListResult/tns:WebShipment", {"tns" => Cargowise::DEFAULT_NS}).map do |node|
        Cargowise::Shipment.new(node)
      end
    end

  end
end
