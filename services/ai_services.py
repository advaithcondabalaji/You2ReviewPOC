import os
from groq import Groq
from dotenv import load_dotenv


load_dotenv()


client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

def generate_movie_sentiment(title, director, genre, release_year):
    """Generates a short AI sentiment summary using Groq."""
    try:
        # the ai thing prompt
        prompt = f"Write a quick, 2-sentence audience sentiment consensus for the {release_year} {genre} movie '{title}' directed by {director}."
        
        chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "system",
                    "content": "You are a movie review summarizer. Provide a concise, engaging 2-sentence summary of general audience sentiment."
                },
                {
                    "role": "user",
                    "content": prompt,
                }
            ],
            
            model="llama-3.1-8b-instant",
            temperature=0.7,
            max_tokens=150
        )
        
        return chat_completion.choices[0].message.content
        
    except Exception as e:
        print(f"Groq API Error: {e}")
        # testing comment
        return f"Unable to load real-time sentiment. Audience consensus generally considers '{title}' to be a memorable {genre} experience."