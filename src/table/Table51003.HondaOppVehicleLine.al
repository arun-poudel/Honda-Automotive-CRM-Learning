table 51003 "Honda Opp. Vehicle Line"
{
    DataClassification = CustomerContent;
    Caption = 'Honda Opp. Vehicle Line';

    fields
    {
        field(1; "Opportunity No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Opportunity No.';
            TableRelation = Opportunity."No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Model Code';
            TableRelation = "Honda Vehicle Model".Code;

            trigger OnValidate()
            var
                VehicleModel: Record "Honda Vehicle Model";
            begin
                if "Model Code" <> '' then begin
                    VehicleModel.Get("Model Code");
                    if not VehicleModel.Active then
                        Error('Model must be active.');
                    if VehicleModel.Blocked then
                        Error('Model must not be blocked.');

                    "Model Description" := VehicleModel.Description;
                    "Product Category" := VehicleModel."Product Category";
                    "Estimated Unit Price" := VehicleModel."Starting Price";

                    "Variant Code" := '';
                    "Variant Description" := '';

                    UpdateLineAmount();
                end else begin
                    "Model Description" := '';
                    "Product Category" := "Product Category"::" ";
                    "Estimated Unit Price" := 0;
                    "Variant Code" := '';
                    "Variant Description" := '';
                    UpdateLineAmount();
                end;
            end;
        }
        field(4; "Model Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Model Description';
        }
        field(5; "Variant Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Honda Vehicle Variant".Code where("Model Code" = field("Model Code"));

            trigger OnValidate()
            var
                VehicleVariant: Record "Honda Vehicle Variant";
            begin
                if "Variant Code" <> '' then begin
                    VehicleVariant.Get("Model Code", "Variant Code");
                    if not VehicleVariant.Active then
                        Error('Variant must be active.');
                    if VehicleVariant.Blocked then
                        Error('Variant must not be blocked.');

                    "Variant Description" := VehicleVariant.Description;
                    if VehicleVariant."Unit Price" > 0 then
                        "Estimated Unit Price" := VehicleVariant."Unit Price";

                    UpdateLineAmount();
                end else begin
                    "Variant Description" := '';
                    // optionally reset price to model base price
                    UpdateLineAmount();
                end;
            end;
        }
        field(6; "Variant Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Description';
        }
        field(7; "Product Category"; Enum "Honda Product Category")
        {
            DataClassification = CustomerContent;
            Caption = 'Product Category';
        }
        field(8; "Preferred Color"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Preferred Color';
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            InitValue = 1;

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(10; "Estimated Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Unit Price';

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(11; "Estimated Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Line Amount';
            Editable = false;
        }
        field(12; "Primary Interest"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Interest';

            trigger OnValidate()
            var
                OtherLines: Record "Honda Opp. Vehicle Line";
                Opportunity: Record Opportunity;
            begin
                if "Primary Interest" then begin
                    // Uncheck others
                    OtherLines.SetRange("Opportunity No.", Rec."Opportunity No.");
                    OtherLines.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    OtherLines.SetRange("Primary Interest", true);
                    if OtherLines.FindSet() then begin
                        repeat
                            OtherLines."Primary Interest" := false;
                            OtherLines.Modify(false);
                        until OtherLines.Next() = 0;
                    end;

                    // Update header
                    if Opportunity.Get(Rec."Opportunity No.") then begin
                        Opportunity."Honda Primary Model Code" := Rec."Model Code";
                        Opportunity."Honda Primary Model Desc." := Rec."Model Description";
                        Opportunity."Honda Primary Variant Code" := Rec."Variant Code";
                        Opportunity.Modify(false);
                    end;
                end else begin
                    if Opportunity.Get(Rec."Opportunity No.") then begin
                        if Opportunity."Honda Primary Model Code" = Rec."Model Code" then begin
                            Opportunity."Honda Primary Model Code" := '';
                            Opportunity."Honda Primary Model Desc." := '';
                            Opportunity."Honda Primary Variant Code" := '';
                            Opportunity.Modify(false);
                        end;
                    end;
                end;
            end;
        }
        field(13; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(PK; "Opportunity No.", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure UpdateLineAmount()
    begin
        "Estimated Line Amount" := Quantity * "Estimated Unit Price";
    end;
}
