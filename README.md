# 💰 RoR Wallet System
A Ruby on Rails application implementing an **internal wallet transactional system** with:
- Generic **Wallets** for Users, Teams, and Stocks.
- **Transactions** using STI (`Credit` / `Debit`) with ACID-safe transfers.
- **Custom sign-in** (no external auth gems).
- Integration with the **Latest Stock Price API** via a gem-style library in `lib/`.

## ⚙️ Features
- 👥 Users, Teams, and Stocks each have their own wallet.
- 💸 Supports **deposits, withdrawals, and transfers** (all atomic).
- 🔑 Custom **sign-in / sign-out** with Rails sessions (using `has_secure_password`).
- 📊 Stock price endpoints backed by **RapidAPI**.
- ✅ Transactions stored in DB with full audit trail (`source_wallet`, `target_wallet`).
- 🔐 No external authentication gem (e.g. Devise) used.

## 📦 Requirements
- Ruby 3.x
- Rails 7.x
- PostgreSQL
- Gems:
  - `pg`
  - `bcrypt`
  - `httparty`
  - `dotenv-rails` (development/test only)

## 🚀 Setup

### 1. Clone & Install
```
git clone <your-repo-url>
cd ror_wallet_app
bundle install
```

### 2. Configure Database
Edit config/database.yml if needed, then:
```
rails db:create db:migrate db:seed
```

### 3. Environment Variables
Create .env:
```
RAPIDAPI_KEY=your_real_api_key_here
```

### 4. Run Server
```
rails s
```

## 💸 Wallet & Transactions
- Each User, Team, Stock has one wallet.
- Balances are calculated as:
    - sum(credits) - sum(debits)
- Transfers are atomic via WalletService.

``` ruby
alice = User.find_by(email: "alice@example.com")
bob   = User.find_by(email: "bob@example.com")

WalletService.transfer(alice.wallet, bob.wallet, 200)

alice.wallet.balance  # => 800
bob.wallet.balance    # => 700
```

## 📊 Stock Price Endpoints
Custom controller (StocksController) uses lib/latest_stock_price/client.rb.

Routes
- GET /stocks/price?symbol=RELIANCE
- GET /stocks/prices?symbols=TCS,INFY,RELIANCE
- GET /stocks/price_all

## 🧪 Testing with REST Client (VS Code)

Transactions
```http
curl -X POST http://localhost:3000/transactions \
  -d "from_wallet_id=2&to_wallet_id=6&amount=700"
```

Sign In
```http
curl -X POST http://localhost:3000/session \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=ayu@example.com&password=ayu123"
```

