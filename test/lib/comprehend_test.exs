defmodule ExAws.ComprehendTest do
  use ExUnit.Case

  test "detect dominant language" do
    text = "Amazon.com, Inc. is located in Seattle, WA and was founded July 5th, 1994 by Jeff Bezos, allowing customers to buy everything from books to blenders.Seattle is north of Portland and south of Vancouver, BC. Other notable Seattle - based companies are Starbucks and Boeing."
    {:ok, response} = text 
                      |> ExAws.Comprehend.detect_dominant_language 
                      |> ExAws.request

    expected = %{"Languages" => [%{"LanguageCode" => "en", "Score" => 0.999245285987854}]}

    assert response == expected
  end

  test "detect entities" do
    text = "It is raining today in Seattle"
    {:ok, response} = text
                      |> ExAws.Comprehend.detect_entities("en") 
                      |> ExAws.request

    expected = %{
        "Entities" => 
          [
            %{
              "BeginOffset" => 14,
              "EndOffset" => 19,
              "Score" => 0.9784814119338989,
              "Text" => "today",
              "Type" => "DATE"
            },
            %{
              "BeginOffset" => 23,
              "EndOffset" => 30,
              "Score" => 0.9954556226730347,
              "Text" => "Seattle",
              "Type" => "LOCATION"
            }
          ]
      }

    assert response == expected
  end

  test "detect key phrases" do
    text = "It is raining today in Seattle"
    {:ok, response} = text
                      |> ExAws.Comprehend.detect_key_phrases("en") 
                      |> ExAws.request

    expected = %{
        "KeyPhrases" => 
          [
            %{
              "BeginOffset" => 14,
              "EndOffset" => 19,
              "Score" => 0.9928804039955139,
              "Text" => "today"
            }
          ]
      }

    assert response == expected
  end

  test "detect sentiment" do
    text = "Amazon.com, Inc. is located in Seattle, WA and was founded July 5th, 1994 by Jeff Bezos, allowing customers to buy everything from books to blenders.Seattle is north of Portland and south of Vancouver, BC. Other notable Seattle - based companies are Starbucks and Boeing"
    {:ok, response} = text
                      |> ExAws.Comprehend.detect_sentiment("en")
                      |> ExAws.request

    expected = %{
        "Sentiment" => "NEUTRAL",
        "SentimentScore" => 
          %{
            "Mixed" => 1.483941450715065e-4,
            "Negative" => 4.403653438203037e-4,
            "Neutral" => 0.9932791590690613,
            "Positive" => 0.006132153328508139
          }
      }

    assert response == expected
  end

  test "detect syntax" do
    text = "It is raining today in Seattle."
    {:ok, response} = text
                      |> ExAws.Comprehend.detect_syntax("en")
                      |> ExAws.request

    expected = 
        %{"SyntaxTokens" => 
          [
            %{"BeginOffset" => 0, "EndOffset" => 2, 
              "PartOfSpeech" => %{"Score" => 0.9999730587005615, "Tag" => "PRON"}, 
              "Text" => "It", 
              "TokenId" => 1}, 
            %{"BeginOffset" => 3, 
              "EndOffset" => 5, 
              "PartOfSpeech" => %{"Score" => 0.9338237643241882, "Tag" => "AUX"}, 
              "Text" => "is", 
              "TokenId" => 2}, 
            %{"BeginOffset" => 6, 
              "EndOffset" => 13, 
              "PartOfSpeech" => %{"Score" => 0.9995366334915161, "Tag" => "VERB"}, 
              "Text" => "raining", 
              "TokenId" => 3}, 
            %{"BeginOffset" => 14, 
              "EndOffset" => 19, 
              "PartOfSpeech" => %{"Score" => 0.9997188448905945, "Tag" => "NOUN"}, 
              "Text" => "today", 
              "TokenId" => 4}, 
            %{"BeginOffset" => 20, 
              "EndOffset" => 22, 
              "PartOfSpeech" => %{"Score" => 0.9999431371688843, "Tag" => "ADP"}, 
              "Text" => "in", 
              "TokenId" => 5}, 
            %{"BeginOffset" => 23, 
              "EndOffset" => 30, 
              "PartOfSpeech" => %{"Score" => 0.9979478716850281, "Tag" => "PROPN"}, 
              "Text" => "Seattle", 
              "TokenId" => 6}, 
            %{"BeginOffset" => 30, 
              "EndOffset" => 31, 
              "PartOfSpeech" => %{"Score" => 0.9999973773956299, "Tag" => "PUNCT"}, 
              "Text" => ".", 
              "TokenId" => 7}
          ]
        }

    assert response == expected
  end

end
