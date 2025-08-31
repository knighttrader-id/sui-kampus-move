module kampus_token::kampus_token {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url::{Self, Url};

    // === STRUCTS ===
    
    // One Time Witness untuk inisialisasi token
    public struct KAMPUS_TOKEN has drop {}
    
    // === INIT FUNCTION ===
    fun init(witness: KAMPUS_TOKEN, ctx: &mut TxContext) {
        // Metadata token
        let (treasury_cap, metadata) = coin::create_currency<KAMPUS_TOKEN>(
            witness,
            9,                                          // Decimals
            b"KAMPUS",                                  // Symbol
            b"Kampus Token",                            // Name
            b"Token untuk sistem kampus blockchain",    // Description
            option::some<Url>(url::new_unsafe_from_bytes(b"https://kampus.io/icon.png")), // Icon URL
            ctx
        );
        
        // Transfer treasury ke deployer untuk kontrol minting
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        
        // Freeze metadata (tidak bisa diubah lagi)
        transfer::public_freeze_object(metadata);
    }
    
    // === MINTING FUNCTIONS ===
    
    // Mint token baru (hanya pemilik treasury)
    public fun mint(
        treasury_cap: &mut TreasuryCap<KAMPUS_TOKEN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        // Mint coin
        let coin = coin::mint(treasury_cap, amount, ctx);
        
        // Transfer ke recipient
        transfer::public_transfer(coin, recipient);
    }
    
    // Burn token (destroy coin)
    public fun burn(treasury_cap: &mut TreasuryCap<KAMPUS_TOKEN>, coin: Coin<KAMPUS_TOKEN>) {
        coin::burn(treasury_cap, coin);
    }
}