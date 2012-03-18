# -*- coding: UTF-8 -*-

module UseCases

  class SeedDatabase < UseCase

    def exec
      destroy_gurus
      create_gurus
      Response.new
    end

    private

    def destroy_gurus
      db[Guru].all.each do |guru| db[guru].destroy end
    end

    def create_gurus
      SEED_GURUS.each do |seed_guru|
        db[Guru].create!(
            name: seed_guru[0],
            homepage: seed_guru[1],
            description: seed_guru[2])
      end
    end

    SEED_GURUS = [
        ['Michael Shermer',
         'http://www.michaelshermer.com',
         'American science writer, historian of science, founder of The Skeptics Society, and Editor in Chief of its magazine Skeptic,[1] which is largely devoted to investigating pseudoscientific and supernatural claims.'],

        ['Ray Kurzweil',
         'https://twitter.com/#!/unclebobmartin',
         'American author, scientist, inventor and futurist. He is involved in fields such as optical character recognition (OCR), text-to-speech synthesis, speech recognition technology, and electronic keyboard instruments. He is the author of several books on health, artificial intelligence (AI), transhumanism, the technological singularity, and futurism.'],

        ['David Heinemeier Hansson (DHH)',
         'http://david.heinemeierhansson.com',
         'The creator of Ruby on Rails, a partner at 37signals, a NYT best-selling author and public speaker.'],

        ['Dave Thomas (Pragmatic Programmer)',
         'http://pragdave.pragprog.com',
         'Author of "The Pragmatic Programmers", "Programming Ruby" and "Agile Web Development with Rails".'],

        ['Robert C. Martin (Uncle Bob)',
         'https://twitter.com/#!/unclebobmartin',
         'Robert C. Martin (Uncle Bob) an award winning author, renowned speaker, and über software geek since 1970.'],
    ]

  end

end
