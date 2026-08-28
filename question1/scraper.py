import requests
from bs4 import BeautifulSoup
from urllib.parse import quote


def search_products(search_term):
    # Convert search term into a URL-friendly format
    encoded_term = quote(search_term)

    # Construct the search URL
    url = f"https://mdcomputers.in/?route=product/search&search={encoded_term}"

    headers = {
        "User-Agent": (
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) "
            "Chrome/151.0.0.0 Safari/537.36"
        ),
        "Accept": (
            "text/html,application/xhtml+xml,application/xml;"
            "q=0.9,*/*;q=0.8"
        ),
        "Accept-Language": "en-US,en;q=0.9",
        "Referer": "https://mdcomputers.in/"
    }

    try:
        # Send request to the website
        response = requests.get(
            url,
            headers=headers,
            timeout=15
        )

        # Check for request errors
        response.raise_for_status()

        # Parse HTML
        soup = BeautifulSoup(response.text, "html.parser")

        # Find product cards
        product_cards = soup.select("div.product-grid-item")

        if not product_cards:
            print("\nNo products found for:", search_term)
            return

        print("\nProducts found for:", search_term)
        print("=" * 60)

        for card in product_cards:

            # Find the actual product link
            product_link = None

            for link in card.select('a[href*="/product/"]'):
                text = link.get_text(" ", strip=True)

                # Ignore discount labels and quick-view links
                if text and not text.startswith("-") and text.lower() != "quick view":
                    product_link = link
                    break

            if not product_link:
                continue

            product_name = product_link.get_text(" ", strip=True)

            # Find all text containing the rupee symbol
            price_texts = []

            for element in card.find_all(string=lambda text: text and "₹" in text):
                text = element.strip()

                if text:
                    price_texts.append(text)

            if not price_texts:
                continue

            # The last price is the selling price
            selling_price = price_texts[-1]

            print("Product Name :", product_name)
            print("Selling Price:", selling_price)
            print("-" * 60)

    except requests.exceptions.RequestException as error:
        print("Error while accessing the website:", error)


# Get search term from the user
search_term = input("Enter search term: ").strip()

if search_term:
    search_products(search_term)
else:
    print("Please enter a valid search term.")