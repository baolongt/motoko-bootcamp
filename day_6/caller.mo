actor{
    // Challenge 8
    type Result<Bool , Text> = {#ok: Bool; #announ : Text};
    let other_canister : actor { mint : () -> async Result<Bool, Text>} = actor("rrkah-fqaaa-aaaaa-aaaaq-cai");
    public shared ({caller}) func mint() : async Result<Bool, Text> {
        return(await other_canister.mint())
    };
}
