;; This contract implements an enhanced version of the SIP-010 Fungible Token standard
(impl-trait .enhanced-sip010-trait.enhanced-sip-010-trait)

;; Define the FT
(define-fungible-token clarity-coin)

;; Define errors
(define-constant ERR_OWNER_ONLY (err u100))
(define-constant ERR_NOT_TOKEN_OWNER (err u101))
(define-constant ERR_INSUFFICIENT_BALANCE (err u102))
(define-constant ERR_INVALID_AMOUNT (err u103))
(define-constant ERR_BLACKLISTED (err u104))
(define-constant ERR_PAUSED (err u105))
(define-constant ERR_CANNOT_BLACKLIST_OWNER (err u106))

;; Define constants for contract
(define-constant CONTRACT_OWNER tx-sender)
(define-constant TOKEN_URI u"https://hiro.so")
(define-constant TOKEN_NAME "Enhanced Clarity Coin")
(define-constant TOKEN_SYMBOL "ECC")
(define-constant TOKEN_DECIMALS u6)
(define-constant MAX_SUPPLY u1000000000000) ;; 1 million tokens with 6 decimals

;; Define data vars
(define-data-var token-paused bool false)
(define-data-var total-minted uint u0)

;; Define data maps
(define-map blacklisted principal bool)

;; SIP-010 functions
(define-read-only (get-balance (who principal))
  (ok (ft-get-balance clarity-coin who))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply clarity-coin))
)

(define-read-only (get-name)
  (ok TOKEN_NAME)
)

(define-read-only (get-symbol)
  (ok TOKEN_SYMBOL)
)

(define-read-only (get-decimals)
  (ok TOKEN_DECIMALS)
)

(define-read-only (get-token-uri)
  (ok (some TOKEN_URI))
)

;; Enhanced functionalities

;; Mint new tokens
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_OWNER_ONLY)
    (asserts! (not (var-get token-paused)) ERR_PAUSED)
    (asserts! (<= (+ (var-get total-minted) amount) MAX_SUPPLY) ERR_INVALID_AMOUNT)
    (asserts! (not (is-blacklisted recipient)) ERR_BLACKLISTED)
    (try! (ft-mint? clarity-coin amount recipient))
    (var-set total-minted (+ (var-get total-minted) amount))
    (ok true)
  )
)

;; Enhanced transfer function
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (not (var-get token-paused)) ERR_PAUSED)
    (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)
    (asserts! (>= (ft-get-balance clarity-coin sender) amount) ERR_INSUFFICIENT_BALANCE)
    (asserts! (> amount u0) ERR_INVALID_AMOUNT)
    (asserts! (not (is-blacklisted sender)) ERR_BLACKLISTED)
    (asserts! (not (is-blacklisted recipient)) ERR_BLACKLISTED)
    (try! (ft-transfer? clarity-coin amount sender recipient))
    (match memo to-print (print to-print) 0x)
    (ok true)
  )
)

;; Burn tokens
(define-public (burn (amount uint) (sender principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)
    (asserts! (>= (ft-get-balance clarity-coin sender) amount) ERR_INSUFFICIENT_BALANCE)
    (try! (ft-burn? clarity-coin amount sender))
    (ok true)
  )
)

;; Pause/unpause token transfers
(define-public (set-paused (paused bool))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_OWNER_ONLY)
    (ok (var-set token-paused paused))
  )
)

;; Blacklist/unblacklist an address
(define-public (set-blacklisted (address principal) (blacklist bool))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_OWNER_ONLY)
    (asserts! (not (is-eq address CONTRACT_OWNER)) ERR_CANNOT_BLACKLIST_OWNER)
    (ok (map-set blacklisted address blacklist))
  )
)

;; Check if an address is blacklisted
(define-read-only (is-blacklisted (address principal))
  (ok (default-to false (map-get? blacklisted address)))
)

;; Get current pause status
(define-read-only (get-paused)
  (ok (var-get token-paused))
)

;; Get total minted tokens
(define-read-only (get-total-minted)
  (ok (var-get total-minted))
)