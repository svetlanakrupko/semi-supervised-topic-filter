library(quanteda)
library(readtext)
library(jsonlite)
library(data.table)
library(keyATM)
library(magrittr)

# Read the JSON file
json_data <- fromJSON("input.json")
text_data <- json_data$text
stop_words <- readLines("stopwords.txt", encoding = "UTF-8")


data_corpus <- corpus(text_data)
data_tokens <- tokens(
    data_corpus,
    remove_numbers = TRUE,
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_separators = TRUE,
    remove_url = TRUE
  ) %>%
  tokens_tolower() %>%
  tokens_remove(stopwords("russian")) %>%
  tokens_select(min_nchar = 3)

data_dfm <- dfm(data_tokens) %>%
              dfm_remove(stop_words) %>%
              dfm_trim(min_termfreq = 5, min_docfreq = 2)
ncol(data_dfm)  # the number of unique words

keyATM_docs <- keyATM_read(texts = data_dfm)
summary(keyATM_docs)

keywords <- list(
  Политика = c(политика, "санкции", запад, экономика, украина, россия),
  Фильм = c("драма", фильм, "реж", "жанр", "кино"),
  Война = c(война, войска, армия),
  История = c("писатель", "века", "родился", "годы")
)

key_viz <- visualize_keywords(docs = keyATM_docs, keywords = keywords)
save_fig(key_viz, "keyword.pdf", width = 6.5, height = 4)
print(values_fig(key_viz))

out <- keyATM(
  docs              = keyATM_docs,
  no_keyword_topics = 10,
  keywords          = keywords,
  model             = "base",
  options           = list(seed = 250)
)
saveRDS(out, file = "final.rds")
print(top_words(out))
