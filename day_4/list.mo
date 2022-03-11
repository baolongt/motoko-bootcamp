module {
    // Challenge 7
    public type List<T> = ?(T, List<T>);
    public func is_null<T>(l : List<T>) : Bool{
        switch(l){
            case(null) { true };
            case(_) { false };
        };
    };

    // Challenge 8
    public func last<T>(l : List<T>) : ?T{
        switch(l){
            case(null) { null };
            case(?(l, null)) { ?l };
            case(?(_, t)) { last<T>(t) };
        }
    };

    // Challenge 9
    public func size<T>(l : List<T>) : Nat{
        switch(l){
            case null { 0 };
            case (?(_, null)) { 1 };
            case (?(_, another_list)) {size<T>(another_list)};
        }
    };


    // Challenge 10
    public func get<T>(l : List<T>, n : Nat) : ?T{
        switch(n, l){
            case (_, null) { null };
            case (0, (?(h, t))) { ?h };
            case (_, (?(_, t))) { get<T>(t, n-1) };
        };
    };

}