tableextension 51001 "Honda Opportunity Ext." extends Opportunity
{
    fields
    {
        field(51001; "Honda Dealer Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Dealer Code';
            TableRelation = "Honda Dealer".Code where(Active = const(true), Blocked = const(false));
        }
        field(51002; "Honda Product Category"; Enum "Honda Product Category")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Product Category';
        }
        field(51003; "Honda CRM Stage"; Enum "Honda Opportunity CRM Stage")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda CRM Stage';
        }
        field(51004; "Honda Result"; Enum "Honda Opportunity Result")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Result';
        }
        field(51005; "Honda Estimated Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Estimated Budget';

            trigger OnValidate()
            begin
                if "Honda Estimated Budget" < 0 then
                    Error('Honda Estimated Budget cannot be negative.');
            end;
        }
        field(51006; "Honda Expected Purch. Date"; Date) // Abbreviated to fit in 30 chars
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Expected Purchase Date';
        }
        field(51007; "Honda Finance Required"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Finance Required';
        }
        field(51008; "Honda Lost Reason"; Enum "Honda Lost Reason")
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Lost Reason';
        }
        field(51009; "Honda Lost Reason Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Lost Reason Remarks';
        }
        field(51010; "Honda Competitor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Competitor Name';
        }
        field(51011; "Honda Ready for Quote Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Ready for Quote Date';
        }
        field(51012; "Honda Closed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Closed Date';
        }
        field(51013; "Honda Last Activity Date"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Honda Last Activity Date';
        }
        field(51014; "Honda Next Activity Date"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Honda Next Activity Date';
        }
        field(51015; "Honda Primary Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Primary Model Code';
            TableRelation = "Honda Vehicle Model".Code;
        }
        field(51016; "Honda Primary Variant Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Primary Variant Code';
            TableRelation = "Honda Vehicle Variant".Code where("Model Code" = field("Honda Primary Model Code"));
        }
        field(51017; "Honda Primary Model Desc."; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Honda Primary Model Desc.';
            Editable = false;
        }
    }
}
