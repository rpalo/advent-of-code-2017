# Advent of Code 2017

**WARNING: Here there be spoilers.**

These are my solutions as I do them for the 2017 Advent of Code challenges.  I'm really open to learn, so if you see a way I could have done better, open an issue and let me know!

## Running the Tests

All you need to run the tests is Rake.

```bash
rake
```

## Create a New Day

I've set things up to make it easy to create a new day so I (and you) can dive right into the puzzle.

```bash
rake new[47,tin_can]
```

This will create a new script `day47.rb`, a file `tin_can.rb` with class `TinCan`, and a test file `tin_can_test.rb` with a test class `TestTinCan < Minitest::Test`.

## Run a Specific Day

You can run a specific day against the text in `input.txt` with:

```bash
rake run[10]
```

The above line will essentially run `cat input.txt | ruby day10.rb`.  I just got tired of typing it.

## Secret Message

For extra fun, because this is for Advent, try:

```bash
rake secret
```