defmodule ExAws.Comprehend do
  @moduledoc """
  Operations on the AWS Comprehend service.

  ## Basic usage
  ```elixir
  
  alias ExAws.Comprehend

  # Detect dominant language
  ExAws.Comprehend.detect_dominant_language("Amazon.com, Inc. is located in Seattle, WA and was founded July 5th, 1994 by Jeff Bezos, allowing customers to buy everything from books to blenders.Seattle is north of Portland and south of Vancouver, BC. Other notable Seattle - based companies are Starbucks and Boeing.")
  |> ExAws.request

  # Detect Entities
  # You must specify the language of the input text
  ExAws.Comprehend.detect_entities("It is raining today in Seattle", "en") 
  |> ExAws.request

  # Detect Sentiment
  # You must specify the language of the input text
  ExAws.Comprehend.detect_sentiment("Amazon.com, Inc. is located in Seattle, WA and was founded July 5th, 1994 by Jeff Bezos, allowing customers to buy everything from books to blenders.Seattle is north of Portland and south of Vancouver, BC. Other notable Seattle - based companies are Starbucks and Boeing", "en")
  |> ExAws.request
  ```
  """

  @namespace "Comprehend_20171127"

  @type text :: binary
  @type language_code :: binary

  @doc """
  Detect dominant language
  """
  @spec detect_dominant_language(
          text :: binary
        ) :: ExAws.Operations.JSON.t()
  def detect_dominant_language(
        text
      ) do

    data = %{"Text" => text}

    request(:detect_dominant_language, data)
  end

  @doc """
  Detect entities

  You must specify the language of the input text.

  Examples
  ```
  ExAws.Comprehend.detect_entities("It is raining today in Seattle", "en") 
  |> ExAws.request
  ```

  """
  @spec detect_entities(
          text :: binary,
          language_code :: binary
        ) :: ExAws.Operations.JSON.t()
  def detect_entities(
        text,
        language_code
      ) do

    data = %{
      "Text" => text,
      "LanguageCode" => language_code
    }

    request(:detect_entities, data)
  end

  @doc """
  Detect key phrases

  You must specify the language of the input text.

  Examples
  ```
  ExAws.Comprehend.detect_key_phrases("It is raining today in Seattle", "en")     
  |> ExAws.request
  ```

  """
  @spec detect_key_phrases(
          text :: binary,
          language_code :: binary
        ) :: ExAws.Operations.JSON.t()
  def detect_key_phrases(
        text,
        language_code
      ) do

    data = %{
      "Text" => text,
      "LanguageCode" => language_code
    }

    request(:detect_key_phrases, data)
  end

  @doc """
  Detect sentiment

  You must specify the language of the input text.

  Examples
  ```
  ExAws.Comprehend.detect_sentiment("Amazon.com, Inc. is located in Seattle, WA and was founded July 5th, 1994 by Jeff Bezos, allowing customers to buy everything from books to blenders.Seattle is north of Portland and south of Vancouver, BC. Other notable Seattle - based companies are Starbucks and Boeing", "en")
  |> ExAws.request
  ```

  """
  @spec detect_sentiment(
          text :: binary,
          language_code :: binary
        ) :: ExAws.Operations.JSON.t()
  def detect_sentiment(
        text,
        language_code
      ) do

    data = %{
      "Text" => text,
      "LanguageCode" => language_code
    }

    request(:detect_sentiment, data)
  end

  @doc """
  Detect syntax

  You must specify the language of the input text.

  Examples
  ```
  ExAws.Comprehend.detect_syntax("It is raining today in Seattle.", "en")
  |> ExAws.request
  ```

  """
  @spec detect_syntax(
          text :: binary,
          language_code :: binary
        ) :: ExAws.Operations.JSON.t()
  def detect_syntax(
        text,
        language_code
      ) do

    data = %{
      "Text" => text,
      "LanguageCode" => language_code
    }

    request(:detect_syntax, data)
  end

  defp request(op, data, opts \\ %{}) do
    operation =
      op
      |> Atom.to_string()
      |> Macro.camelize()

    ExAws.Operation.JSON.new(
      :comprehend,
      %{
        data: data,
        headers: [
          {"x-amz-target", "#{@namespace}.#{operation}"},
          {"content-type", "application/x-amz-json-1.1"}
        ]
      }
      |> Map.merge(opts)
    )
  end

end
