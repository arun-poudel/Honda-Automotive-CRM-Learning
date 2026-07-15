tableextension 51000 "Honda Contact Ext." extends Contact
{
    fields
    {
        field(51001; "Honda Customer Type"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Customer Type';
        }
        field(51002; "Honda Lead Source"; Enum "Honda Lead Source")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Lead Source';
        }
        field(51003; "Honda Preferred Dealer Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Preferred Dealer Code';
            TableRelation = "Honda Dealer".Code where(Active = const(true), Blocked = const(false));

            trigger OnValidate()
            var
                Dealer: Record "Honda Dealer";
            begin
                if "Honda Preferred Dealer Code" <> '' then begin
                    Dealer.Get("Honda Preferred Dealer Code");
                    if not Dealer.Active then
                        Error('The selected dealer is not active.');
                    if Dealer.Blocked then
                        Error('The selected dealer is blocked.');
                end;
            end;
        }
        field(51004; "Honda Product Category"; Enum "Honda Product Category")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Product Category';
        }
        field(51005; "Honda Preferred Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Preferred Model Code';
            TableRelation = "Honda Vehicle Model".Code;

            trigger OnValidate()
            var
                Model: Record "Honda Vehicle Model";
            begin
                if "Honda Preferred Model Code" <> '' then begin
                    Model.Get("Honda Preferred Model Code");
                    if not Model.Active then
                        Error('The selected model is not active.');
                    if Model.Blocked then
                        Error('The selected model is blocked.');

                    "Honda Preferred Model Desc." := Model.Description;
                    if "Honda Product Category" = "Honda Product Category"::" " then
                        "Honda Product Category" := Model."Product Category"
                    else if "Honda Product Category" <> Model."Product Category" then
                        Error('The selected model belongs to a different product category than currently selected.');
                end else begin
                    "Honda Preferred Model Desc." := '';
                end;
            end;
        }
        field(51006; "Honda Preferred Model Desc."; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Preferred Model Desc.';
            Editable = false;
        }
        field(51007; "Honda Province"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Province';
        }
        field(51008; "Honda District"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda District';
        }
        field(51009; "Honda Municipality"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Municipality';
        }
        field(51010; "Honda Citizenship No."; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Honda Citizenship No.';
        }
        field(51011; "Honda Last Attempted Date"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Honda Last Attempted Date';
        }
        field(51012; "Honda Next Task Date"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Honda Next Task Date';
        }
        field(51013; "Honda Contact Preference"; Enum "Honda Contact Preference")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Contact Preference';
        }
        field(51014; "Honda Consent to Contact"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Consent to Contact';

            trigger OnValidate()
            begin
                if "Honda Consent to Contact" then begin
                    "Honda Consent Date" := WorkDate();
                    "Honda Do Not Contact" := false;
                end;
            end;
        }
        field(51015; "Honda Consent Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Consent Date';
        }
        field(51016; "Honda Do Not Contact"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Do Not Contact';

            trigger OnValidate()
            begin
                if "Honda Do Not Contact" then
                    "Honda Consent to Contact" := false;
            end;
        }
    }
}
