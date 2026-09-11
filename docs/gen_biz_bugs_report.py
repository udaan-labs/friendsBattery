"""One-shot Hinglish business-logic bug report PDF generator."""
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_JUSTIFY, TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import (
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
    KeepTogether,
)

OUT = Path(__file__).with_name("FriendsBattery_Business_Logic_Bugs_Hinglish.pdf")

styles = getSampleStyleSheet()
styles.add(
    ParagraphStyle(
        name="HTitle",
        parent=styles["Title"],
        fontSize=16,
        spaceAfter=6,
        alignment=TA_CENTER,
        textColor=colors.HexColor("#111827"),
    )
)
styles.add(
    ParagraphStyle(
        name="HSub",
        parent=styles["Normal"],
        fontSize=9,
        alignment=TA_CENTER,
        textColor=colors.HexColor("#4B5563"),
        spaceAfter=14,
    )
)
styles.add(
    ParagraphStyle(
        name="HHead",
        parent=styles["Heading2"],
        fontSize=12,
        spaceBefore=10,
        spaceAfter=6,
        textColor=colors.HexColor("#1F2937"),
    )
)
styles.add(
    ParagraphStyle(
        name="HBody",
        parent=styles["Normal"],
        fontSize=9,
        leading=12,
        alignment=TA_JUSTIFY,
        spaceAfter=6,
    )
)
styles.add(
    ParagraphStyle(
        name="BugTitle",
        parent=styles["Normal"],
        fontSize=9.5,
        leading=12,
        fontName="Helvetica-Bold",
        spaceBefore=4,
        spaceAfter=2,
        textColor=colors.HexColor("#111827"),
    )
)
styles.add(
    ParagraphStyle(
        name="BugBody",
        parent=styles["Normal"],
        fontSize=8.5,
        leading=11,
        alignment=TA_LEFT,
        spaceAfter=2,
    )
)
styles.add(
    ParagraphStyle(
        name="Meta",
        parent=styles["Normal"],
        fontSize=8,
        textColor=colors.HexColor("#6B7280"),
        spaceAfter=8,
    )
)
styles.add(
    ParagraphStyle(
        name="Cell",
        parent=styles["Normal"],
        fontSize=8,
        leading=10,
    )
)

sev_color = {
    "P0": colors.HexColor("#FEE2E2"),
    "P1": colors.HexColor("#FEF3C7"),
    "P2": colors.HexColor("#E0E7FF"),
}


def bug(sev, title, where, wrong, impact):
    return KeepTogether(
        [
            Paragraph(f"[{sev}] {title}", styles["BugTitle"]),
            Paragraph(f"<b>Kahan:</b> {where}", styles["BugBody"]),
            Paragraph(f"<b>Galat kya hai:</b> {wrong}", styles["BugBody"]),
            Paragraph(f"<b>Business impact:</b> {impact}", styles["BugBody"]),
            Spacer(1, 4),
        ]
    )


story = []
story.append(Paragraph("FriendsBattery — Quick Audit Report", styles["HTitle"]))
story.append(
    Paragraph(
        "Business logic bugs jo miss ho sakte hain · Hinglish short report · 4 parallel audits",
        styles["HSub"],
    )
)
story.append(
    Paragraph(
        "Date: 2026-09-06 · Scope: inventory/ledger, sales/shipments/returns, IDOR/RBAC, Flutter domain gaps. "
        "Style/perf out of scope. Code cite based on current tree.",
        styles["Meta"],
    )
)

story.append(Paragraph("1) App abhi kaise build hai (short)", styles["HHead"]))
story.append(
    Paragraph(
        "Ye battery inventory + sales app hai. <b>Backend:</b> Node/Express 5 + Prisma/PostgreSQL — "
        "route → auth/RBAC → Zod → controller → service → repository. "
        "<b>Frontend:</b> Flutter + Riverpod + go_router; API models OpenAPI-generated "
        "(<font face='Courier'>friends_battery_api</font>), Dio sirf transport. "
        "<b>Domain core:</b> har physical battery = ek <font face='Courier'>product_units</font> serial; "
        "<font face='Courier'>inventory_transactions</font> append-only ledger. Roles: SUPER_ADMIN → ADMIN → SELLER → EMPLOYEE. "
        "Stock move ab mainly <font face='Courier'>/api/shipments</font> se; purana <font face='Courier'>/api/transfers</font> + "
        "unused <font face='Courier'>StockRequest</font> schema abhi bhi zinda hai (bloat + confusion).",
        styles["HBody"],
    )
)

# Summary table
story.append(Paragraph("2) Executive summary (priority)", styles["HHead"]))
rows = [
    [
        Paragraph("<b>Sev</b>", styles["Cell"]),
        Paragraph("<b>Area</b>", styles["Cell"]),
        Paragraph("<b>Top risk (ek line)</b>", styles["Cell"]),
    ],
    [
        Paragraph("P0", styles["Cell"]),
        Paragraph("IDOR / Admin", styles["Cell"]),
        Paragraph(
            "Shop Admin dusre shops ka stock move/destroy/activate + sales history padh sakta hai.",
            styles["Cell"],
        ),
    ],
    [
        Paragraph("P0", styles["Cell"]),
        Paragraph("Shipments", styles["Cell"]),
        Paragraph(
            "Pending shipment units forever lock — cancel/reject API missing.",
            styles["Cell"],
        ),
    ],
    [
        Paragraph("P0", styles["Cell"]),
        Paragraph("Returns", styles["Cell"]),
        Paragraph(
            "Return ke baad unit RETURNED pe stuck; employee sales return nahi ho sakti.",
            styles["Cell"],
        ),
    ],
    [
        Paragraph("P0", styles["Cell"]),
        Paragraph("Concurrency", styles["Cell"]),
        Paragraph(
            "Transfer/adjust non-atomic — sold unit dubara assign ho sakti hai.",
            styles["Cell"],
        ),
    ],
    [
        Paragraph("P1", styles["Cell"]),
        Paragraph("Money UI", styles["Cell"]),
        Paragraph(
            "Service/Rent CREDIT fake; PDF revenue = sellPrice not cash collected.",
            styles["Cell"],
        ),
    ],
]
t = Table(rows, colWidths=[18 * mm, 32 * mm, 130 * mm])
t.setStyle(
    TableStyle(
        [
            ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#F3F4F6")),
            ("BACKGROUND", (0, 1), (-1, 1), sev_color["P0"]),
            ("BACKGROUND", (0, 2), (-1, 2), sev_color["P0"]),
            ("BACKGROUND", (0, 3), (-1, 3), sev_color["P0"]),
            ("BACKGROUND", (0, 4), (-1, 4), sev_color["P0"]),
            ("BACKGROUND", (0, 5), (-1, 5), sev_color["P1"]),
            ("GRID", (0, 0), (-1, -1), 0.4, colors.HexColor("#D1D5DB")),
            ("VALIGN", (0, 0), (-1, -1), "TOP"),
            ("LEFTPADDING", (0, 0), (-1, -1), 4),
            ("RIGHTPADDING", (0, 0), (-1, -1), 4),
            ("TOPPADDING", (0, 0), (-1, -1), 3),
            ("BOTTOMPADDING", (0, 0), (-1, -1), 3),
        ]
    )
)
story.append(t)
story.append(Spacer(1, 8))

story.append(Paragraph("3) Inventory / Ledger bugs", styles["HHead"]))
story.append(
    bug(
        "P0",
        "Non-atomic unit update — double-assign / sold unit corrupt",
        "inventory.repository.js → updateInventory; transferInventory / adjust / removeUnit",
        "Unit pehle select, phir sirf id se update. Sales jaisa atomic status claim nahi. Concurrent sale+transfer same serial move kar sakte hain.",
        "Galat owner, ya sold battery ka ownership flip — stock vs reality mismatch. Paisa + warranty dono toot sakte hain.",
    )
)
story.append(
    bug(
        "P0",
        "Customer return = permanent unsellable stock",
        "returns.repository.js → processReturn (status RETURNED)",
        "Return SOLD→RETURNED karta hai, lekin RETURNED→AVAILABLE (restock) ka koi path nahi. Sale/ship sirf AVAILABLE accept karte hain.",
        "Har successful return ek physical battery ko system se nikaal deta hai — restock impossible without DB patch.",
    )
)
story.append(
    bug(
        "P0",
        "New shipment units forever lock (no cancel/reject)",
        "shipments.repository.js → transferUnitsToSeller",
        "Create pe units AVAILABLE→IN_SHIPMENT. Seller accept ke alawa unlock nahi. Legacy transfers cancel hai, new shipments pe nahi.",
        "Galat seller / abandoned shipment = inventory limbo. Serial sell/reassign nahi hota.",
    )
)
story.append(
    bug(
        "P1",
        "products.stockQuantity parallel counter drift",
        "Product.stockQuantity; updateStock / ship create; sales/returns sync nahi",
        "Unit-based rule ke against denormalized counter. Sirf kuch paths update karti hain.",
        "Jo UI/API is number pe trust kare, woh galat on-hand dikhayega vs real AVAILABLE serials.",
    )
)
story.append(
    bug(
        "P1",
        "Legacy quantity transfers + dual transfer systems",
        "transfers.* vs /api/shipments vs POST /api/inventory/transfer",
        "Quantity transfer serial reserve nahi karta; receive baad mein arbitrary AVAILABLE units le leta hai. Do systems parallel.",
        "Over-commit, unpredictable receive, wrong batteries seller ko mil sakti hain.",
    )
)

story.append(Paragraph("4) Sales / Returns / Money bugs", styles["HHead"]))
story.append(
    bug(
        "P0",
        "Employee/Admin POS sales return nahi ho sakti",
        "returns.routes (requireSeller); processReturn checks latestSale.sellerId",
        "Employee sale pe sellerId = employee. Returns API sirf SELLER + matching sellerId. Employee return route missing.",
        "Counter/staff sales pe warranty-return flow broken. Unit SOLD pe stuck.",
    )
)
story.append(
    bug(
        "P1",
        "Return money reverse nahi hota",
        "returns.repository processReturn",
        "Physical return + ledger, lekin amountPaid / credit due touch nahi.",
        "Books pe returned unit ka paisa/credit open dikhta rehta hai — cash vs inventory mismatch.",
    )
)
story.append(
    bug(
        "P1",
        "Service bill CREDIT fake; Rent CREDIT collect path missing",
        "create_service_bill_screen / battery_rent_screen + BillPaymentModePicker",
        "UI CREDIT offer karti hai, lekin service/rent pe amountDue/pay-later API nahi. Share text 'Amount Paid' jaisa dikhata hai.",
        "Unpaid service/rent deposit settled lagta hai; collection track nahi hoti.",
    )
)
story.append(
    bug(
        "P1",
        "Seller sales history employee credit miss karti hai",
        "seller_sales_repository → apiSalesHistoryGet; backend seller scope = self only",
        "Staff sales location-scoped hain; seller list sirf apni rows.",
        "Employee ne jo CREDIT becha, shop seller Due list mein nahi — collection miss.",
    )
)
story.append(
    bug(
        "P2",
        "Admin sales PDF 'revenue' = full sellPrice",
        "admin_sales_report_pdf.dart",
        "Total booked price fold karta hai; amountPaid / due ignore.",
        "Credit sales se revenue inflate — management galat cash soch sakta hai.",
    )
)

story.append(Paragraph("5) Auth / IDOR / RBAC bugs (bahut serious)", styles["HHead"]))
story.append(
    Paragraph(
        "Pattern: kai jagah ADMIN ko SUPER_ADMIN jaisa treat kiya gaya, ya body/query id pe trust.",
        styles["HBody"],
    )
)
story.append(
    bug(
        "P0",
        "Shop Admin kisi bhi account ko activate/deactivate kar sakta hai",
        "auth.service activateUser · PUT /api/auth/activate",
        "requireSuperAdminOrAdmin only; shop scope / assertAccess nahi. body.user_id = permission.",
        "Rival sellers lock-out, foreign accounts enable — org takeover risk.",
    )
)
story.append(
    bug(
        "P0",
        "adjustInventory body.user_id pe trust",
        "inventory.controller/service adjustInventory",
        "Actor shop check nahi; kisi bhi ADMIN/SA/SELLER pe units mint/drain.",
        "Cross-shop stock theft / sabotage via API.",
    )
)
story.append(
    bug(
        "P0",
        "removeUnit ownership ignore",
        "inventory.service removeUnit",
        "Koi bhi AVAILABLE serial DEFECTIVE; owner/shop assertAccess nahi.",
        "Dusre shop ka physical inventory destroy via serial.",
    )
)
story.append(
    bug(
        "P0",
        "Admin sales history ?sellerId shop scope bypass",
        "sales.service getAdminSalesHistory · _sellerScopeWhere",
        "Client sellerId shop sellerIds ko replace kar deta hai.",
        "Shop Admin dusre shops ki sales/customers/prices padh sakta hai.",
    )
)
story.append(
    bug(
        "P0",
        "POST /api/inventory/transfer seller shop check skip",
        "inventory.service transferInventory",
        "Seller exists check only; isUserInShopScope nahi (shipments mein hai).",
        "Admin org-wide kisi bhi seller ko stock bhej de.",
    )
)
story.append(
    bug(
        "P1",
        "Inventory history + verifyProduct + getInventoryItem location IDOR",
        "inventory getHistory; product-units verifyProduct; getInventoryItem location_id",
        "Admin-like = org-wide / foreign location without assertAccess.",
        "Cross-shop ledger, customer phone, serial lists leak.",
    )
)

story.append(Paragraph("6) Flutter-specific domain gaps", styles["HHead"]))
story.append(
    bug(
        "P1",
        "SA 'Remove quantity' vs org-wide displayed stock",
        "admin_edit_inventory_bottom_sheet + adjustInventory(auth_id)",
        "List org-wide dikhati hai; write sirf logged-in SA ke owned AVAILABLE units pe.",
        "Galat write-off / false 'enough stock' feeling.",
    )
)
story.append(
    bug(
        "P1",
        "Quantity remove = random serials DEFECTIVE",
        "Same bottom sheet → adjustInventory",
        "Serial-unit domain hai; quantity path arbitrary units pick karti hai, scan confirm nahi.",
        "Galat batteries scrap; good serials reh jaate hain — physical vs ledger mismatch.",
    )
)
story.append(
    bug(
        "P0",
        "Return UI verify OK, submit 403 on employee-sold units",
        "seller_return_product_screen + returns.service",
        "Verify ownership pe pass; submit latestSale.sellerId match maangta hai.",
        "Seller confuse + failed warranty; unit SOLD pe rehti hai.",
    )
)

story.append(Paragraph("7) Jo comparatively solid hai", styles["HHead"]))
story.append(
    Paragraph(
        "Sale/rent paths mein atomic AVAILABLE claim + SOLD ledger; new shipment accept pe "
        "PENDING→ACCEPTED atomic claim; credit overpay Zod + optimistic lock — ye paths better hain. "
        "Sabse kharab gaps: IDOR on admin inventory/auth, non-atomic transfers, return dead-end, "
        "uncancelable IN_SHIPMENT, money UI fake CREDIT.",
        styles["HBody"],
    )
)

story.append(Paragraph("8) Suggested fix order (MVP)", styles["HHead"]))
story.append(
    Paragraph(
        "1) <b>IDOR patch pehle:</b> activate, adjust, removeUnit, inventory transfer, admin sales sellerId, history/verify/location — sab pe shop scope + req.user only.<br/>"
        "2) <b>Shipment cancel/reject</b> + units AVAILABLE restore + stockQuantity rollback (ya stockQuantity hatao).<br/>"
        "3) <b>Return restock policy</b> (AVAILABLE / DEFECTIVE) + employee/admin sale return path + money reverse.<br/>"
        "4) <b>Atomic unit updates</b> (status+owner WHERE claim) on transfer/adjust/remove.<br/>"
        "5) Legacy <font face='Courier'>/api/transfers</font> + dead StockRequest cut (ponytail) — confusion kam.<br/>"
        "6) Flutter: fake CREDIT hatao ya real due/pay wire; PDF amountPaid use karo; quantity scrap → serial confirm.",
        styles["HBody"],
    )
)

story.append(Spacer(1, 10))
story.append(
    Paragraph(
        "Note: Alag se ponytail-audit (over-engineering cut-list) chat mein diya gaya — woh correctness bugs nahi, bloat delete list hai.",
        styles["Meta"],
    )
)

doc = SimpleDocTemplate(
    str(OUT),
    pagesize=A4,
    leftMargin=16 * mm,
    rightMargin=16 * mm,
    topMargin=14 * mm,
    bottomMargin=14 * mm,
    title="FriendsBattery Business Logic Bugs (Hinglish)",
    author="Grok audit",
)
doc.build(story)
print(OUT)
