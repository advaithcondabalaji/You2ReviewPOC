import os
from dotenv import load_dotenv

load_dotenv()

def generate_movie_sentiment(title, director=None, genre=None, release_year=None):
    """Generates an AI-powered audience sentiment summary using Groq."""
    api_key = os.getenv('GROQ_API_KEY')
    
    if not api_key:
        print("❌ GROQ_API_KEY is missing from environment variables.")
        return f"Audience consensus generally considers '{title}' to be a memorable {genre or 'film'}."

    try:
        from groq import Groq
        client = Groq(api_key=api_key)

        prompt = (
            f"Provide a brief, 2-3 sentence AI audience sentiment analysis for the movie '{title}' "
            f"directed by {director or 'Unknown'}, genre: {genre or 'General'}, released in {release_year or 'N/A'}. "
            f"Summarize overall viewer reaction, key praised aspects, and general reception."
        )

        # Using actively supported Groq model
        response = client.chat.completions.create(
            model="llama-3.1-8b-instant",
            messages=[
                {
                    "role": "system",
                    "content": "You are a concise movie critic and sentiment analyzer. Keep responses under 60 words."
                },
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            max_tokens=120,
            temperature=0.7
        )

        return response.choices[0].message.content.strip()

    except Exception as e:
        print(f"❌ GROQ AI ERROR: {e}")
        return f"Audience consensus generally considers '{title}' to be a memorable {genre or 'film'}."