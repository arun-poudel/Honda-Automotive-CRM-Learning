codeunit 51002 "Honda CRM Setup Data"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InsertDealers();
        InsertModelsAndVariants();
        InsertSalespersons();
        InsertContacts();
    end;

    local procedure InsertDealers()
    var
        Dealer: Record "Honda Dealer";
    begin
        if Dealer.Get('KTM-SHOWROOM') then exit;

        Dealer.Init();
        Dealer.Code := 'KTM-SHOWROOM';
        Dealer.Name := 'Kathmandu Showroom';
        Dealer."Dealer Type" := Dealer."Dealer Type"::Showroom;
        Dealer.Active := true;
        Dealer.Insert(true);

        Dealer.Init();
        Dealer.Code := 'LTP-3S';
        Dealer.Name := 'Lalitpur 3S Facility';
        Dealer."Dealer Type" := Dealer."Dealer Type"::"3S Facility";
        Dealer.Active := true;
        Dealer.Insert(true);

        Dealer.Init();
        Dealer.Code := 'PKR-SHOWROOM';
        Dealer.Name := 'Pokhara Showroom';
        Dealer."Dealer Type" := Dealer."Dealer Type"::Showroom;
        Dealer.Active := false;
        Dealer.Blocked := true;
        Dealer.Insert(true);
    end;

    local procedure InsertModelsAndVariants()
    var
        Model: Record "Honda Vehicle Model";
        Variant: Record "Honda Vehicle Variant";
    begin
        if Model.Get('SHINE') then exit;

        // Motorcycles
        Model.Init();
        Model.Code := 'SHINE';
        Model.Description := 'Honda Shine 125';
        Model."Product Category" := Model."Product Category"::Motorcycle;
        Model.Active := true;
        Model.Insert(true);

        Variant.Init();
        Variant."Model Code" := 'SHINE';
        Variant.Code := 'DRUM';
        Variant.Description := 'Shine Drum Brake';
        Variant.Active := true;
        Variant.Insert(true);

        Variant.Init();
        Variant."Model Code" := 'SHINE';
        Variant.Code := 'DISC';
        Variant.Description := 'Shine Disc Brake';
        Variant.Active := true;
        Variant.Insert(true);

        Model.Init();
        Model.Code := 'UNICORN';
        Model.Description := 'Honda Unicorn 160';
        Model."Product Category" := Model."Product Category"::Motorcycle;
        Model.Active := true;
        Model.Insert(true);

        // Scooters
        Model.Init();
        Model.Code := 'DIO';
        Model.Description := 'Honda Dio';
        Model."Product Category" := Model."Product Category"::Scooter;
        Model.Active := true;
        Model.Insert(true);

        Variant.Init();
        Variant."Model Code" := 'DIO';
        Variant.Code := 'STD';
        Variant.Description := 'Dio Standard';
        Variant.Active := true;
        Variant.Insert(true);

        Model.Init();
        Model.Code := 'ACTIVA';
        Model.Description := 'Honda Activa 6G';
        Model."Product Category" := Model."Product Category"::Scooter;
        Model.Active := true;
        Model.Insert(true);

        // Automobiles
        Model.Init();
        Model.Code := 'CITY';
        Model.Description := 'Honda City';
        Model."Product Category" := Model."Product Category"::Automobile;
        Model.Active := true;
        Model.Insert(true);

        Variant.Init();
        Variant."Model Code" := 'CITY';
        Variant.Code := 'V';
        Variant.Description := 'City V MT';
        Variant.Active := true;
        Variant.Insert(true);

        Variant.Init();
        Variant."Model Code" := 'CITY';
        Variant.Code := 'ZX';
        Variant.Description := 'City ZX CVT';
        Variant.Active := true;
        Variant.Insert(true);

        Model.Init();
        Model.Code := 'AMAZ';
        Model.Description := 'Honda Amaze';
        Model."Product Category" := Model."Product Category"::Automobile;
        Model.Active := true;
        Model.Insert(true);

        // Power Product
        Model.Init();
        Model.Code := 'GEN2000';
        Model.Description := 'Honda Generator 2000W';
        Model."Product Category" := Model."Product Category"::"Power Product";
        Model.Active := true;
        Model.Insert(true);
    end;

    local procedure InsertSalespersons()
    var
        SP: Record "Salesperson/Purchaser";
    begin
        if not SP.Get('SP-ALEX') then begin
            SP.Init();
            SP.Code := 'SP-ALEX';
            SP.Name := 'Alex Sales';
            SP.Insert(true);
        end;

        if not SP.Get('SP-SARA') then begin
            SP.Init();
            SP.Code := 'SP-SARA';
            SP.Name := 'Sara Seller';
            SP.Insert(true);
        end;
    end;

    local procedure InsertContacts()
    var
        Contact: Record Contact;
    begin
        Contact.SetRange(Name, 'Walkin Lead');
        if not Contact.IsEmpty() then exit;

        CreateContact('CT-001', 'Walkin Lead', '9800000001', 'walkin@example.com', "Honda Lead Source"::"Walk In", 'SP-ALEX', 'KTM-SHOWROOM', 'SHINE', false);
        CreateContact('CT-002', 'Web Lead', '9800000002', 'web@example.com', "Honda Lead Source"::Website, 'SP-SARA', 'LTP-3S', 'CITY', false);
        CreateContact('CT-003', 'Referral Lead', '9800000003', 'ref@example.com', "Honda Lead Source"::Referral, 'SP-ALEX', 'KTM-SHOWROOM', 'DIO', false);
        CreateContact('CT-004', 'Duplicate Phone', '9800000001', 'dup1@example.com', "Honda Lead Source"::Phone, 'SP-SARA', 'LTP-3S', 'ACTIVA', false);
        CreateContact('CT-005', 'Duplicate Email', '9800000004', 'walkin@example.com', "Honda Lead Source"::Phone, 'SP-ALEX', 'KTM-SHOWROOM', 'UNICORN', false);
        CreateContact('CT-006', 'Do Not Contact', '9800000005', 'dnc@example.com', "Honda Lead Source"::Other, 'SP-SARA', 'LTP-3S', 'CITY', true);
    end;

    local procedure CreateContact(No: Code[20]; Name: Text[100]; Phone: Text[30]; Email: Text[80]; Source: Enum "Honda Lead Source"; SPCode: Code[20]; Dealer: Code[20]; Model: Code[20]; DNC: Boolean)
    var
        Contact: Record Contact;
    begin
        if Contact.Get(No) then exit;

        Contact.Init();
        Contact."No." := No;
        Contact.Name := Name;
        Contact."Phone No." := Phone;
        Contact."E-Mail" := Email;
        Contact."Honda Lead Source" := Source;
        Contact."Salesperson Code" := SPCode;
        Contact."Honda Preferred Dealer Code" := Dealer;
        Contact.Validate("Honda Preferred Model Code", Model);
        Contact."Honda Do Not Contact" := DNC;
        Contact.Insert(true);
    end;
}
