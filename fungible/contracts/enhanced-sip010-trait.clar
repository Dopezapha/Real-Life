(use-trait sip-010-trait .sip010-ft-trait.sip-010-trait)

(define-trait enhanced-sip-010-trait
  (
    ;; Include all SIP-010 functions
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))
    (get-balance (principal) (response uint uint))
    (get-total-supply () (response uint uint))
    (get-name () (response (string-ascii 32) uint))
    (get-symbol () (response (string-ascii 32) uint))
    (get-decimals () (response uint uint))
    (get-token-uri () (response (optional (string-utf8 256)) uint))
    
    ;; Additional functions for enhanced functionality
    (mint (uint principal) (response bool uint))
    (burn (uint principal) (response bool uint))
    (set-paused (bool) (response bool uint))
    (set-blacklisted (principal bool) (response bool uint))
    (is-blacklisted (principal) (response bool uint))
    (get-paused () (response bool uint))  ;; Changed to return (response bool uint)
    (get-total-minted () (response uint uint))
  )
)