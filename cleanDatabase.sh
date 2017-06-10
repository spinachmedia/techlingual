#!/bin/bash

rake crawl_word:execute
rake marge_count:execute
rake set_means_for_word:execute
