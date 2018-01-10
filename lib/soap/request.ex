defmodule Soap.Request do
  @moduledoc """
  Documentation for Soap.Request.
  """
  alias Soap.Request.Params

  @doc """
  Executing with parsed wsdl and headers with body map.
  Calling HTTPoison request by Map with method, url, body, headers, options keys.
  """
  @spec call(wsdl :: map(), soap_action :: String.t(), params :: map()) :: tuple()
  def call(wsdl, soap_action, headers \\ [], params) do
    url = Params.get_url(wsdl)
    headers = Params.build_headers(soap_action, headers)
    body = Params.build_body(soap_action, params)

    response = HTTPoison.post!(url, body, headers)
    handle_response(response)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: body
end
