---
name: BatteryPro Design System
colors:
  surface: '#f7f9fb'
  surface-dim: '#d8dadc'
  surface-bright: '#f7f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e6e8ea'
  surface-container-highest: '#e0e3e5'
  on-surface: '#191c1e'
  on-surface-variant: '#3e4a3d'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#6e7b6c'
  outline-variant: '#bdcaba'
  surface-tint: '#006e2d'
  primary: '#006b2c'
  on-primary: '#ffffff'
  primary-container: '#00873a'
  on-primary-container: '#f7fff2'
  inverse-primary: '#62df7d'
  secondary: '#545f73'
  on-secondary: '#ffffff'
  secondary-container: '#d5e0f8'
  on-secondary-container: '#586377'
  tertiary: '#0051d5'
  on-tertiary: '#ffffff'
  tertiary-container: '#316bf3'
  on-tertiary-container: '#fefcff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#7ffc97'
  primary-fixed-dim: '#62df7d'
  on-primary-fixed: '#002109'
  on-primary-fixed-variant: '#005320'
  secondary-fixed: '#d8e3fb'
  secondary-fixed-dim: '#bcc7de'
  on-secondary-fixed: '#111c2d'
  on-secondary-fixed-variant: '#3c475a'
  tertiary-fixed: '#dbe1ff'
  tertiary-fixed-dim: '#b4c5ff'
  on-tertiary-fixed: '#00174b'
  on-tertiary-fixed-variant: '#003ea8'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 57px
    fontWeight: '700'
    lineHeight: 64px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 48px
---

## Brand & Style
The brand personality is rooted in reliability, efficiency, and environmental consciousness. As a battery management system, the interface must communicate "health" and "stability" at a glance. The target audience ranges from homeowners monitoring solar storage to fleet managers overseeing electric vehicle batteries; therefore, the UI avoids technical jargon in favor of intuitive visual cues.

The design style follows a **Corporate / Modern** aesthetic, heavily influenced by Material Design 3. It prioritizes functional clarity over decorative elements. By utilizing high-contrast layouts, generous whitespace, and a strict no-gradient policy, the system ensures that critical data—such as charge levels and temperature—is immediately legible. The emotional response should be one of "calm control."

## Colors
This design system utilizes a high-contrast palette to ensure accessibility and professional appeal. 

- **Primary (Green):** Symbolizes energy, health, and "go" status. It is used for primary actions, active toggle states, and positive health indicators.
- **Secondary (Slate):** A deep dark gray used for sidebars, primary navigation, and headers to provide a grounded, professional feel.
- **Background:** Pure white (#FFFFFF) is used for the main canvas to maintain a clean SaaS aesthetic.
- **Neutral:** Light grays are used for card backgrounds and subtle borders to distinguish content areas without adding visual noise.
- **Functional Colors:** Error states must use a high-visibility Red (#DC2626) to contrast sharply against the primary green.

## Typography
Inter is the exclusive typeface for this design system, chosen for its exceptional legibility on digital screens and its neutral, modern tone. 

The type hierarchy is designed to be "large and readable" to accommodate non-technical users who may be viewing data in various lighting conditions. **Display** and **Headline** roles are used for primary metrics like "98% Charged." **Body** text is sized slightly larger than standard (16px-18px) to reduce eye strain. **Labels** use a medium or semi-bold weight to ensure that even small metadata remains actionable and clear.

## Layout & Spacing
The design system employs a **Fluid Grid** model based on an 8px spacing rhythm. 

- **Desktop:** 12-column grid with 24px gutters and large 48px outside margins to create a focused, "contained" software feel.
- **Tablet:** 8-column grid with 20px gutters.
- **Mobile:** 4-column grid with 16px margins. 

Large touch targets are a priority. Interactive elements like buttons and list items must have a minimum height of 48px. Layouts should utilize "Surface-Container" logic, where information is grouped into cards rather than separated by harsh lines.

## Elevation & Depth
In line with Material Design 3 principles, depth is primarily conveyed through **Tonal Layers** and **Ambient Shadows**.

- **Level 0 (Floor):** The main background (White).
- **Level 1 (Cards):** Low-contrast surfaces (#F8FAFC) with a very soft, diffused shadow (Blur: 12px, Y: 4, Opacity: 4% Black). No borders are used here.
- **Level 2 (Active/Hover):** When a card or element is interacted with, the shadow intensity increases slightly (Blur: 20px, Y: 8, Opacity: 8% Black) to simulate the element lifting toward the user.

Avoid heavy drop shadows or glow effects. The goal is to create a subtle sense of physical layers stacked on a desk.

## Shapes
The shape language is defined by **Soft Roundedness**. A standard corner radius of 16px (`rounded-lg` in this system) is applied to all primary containers and cards to evoke a friendly, modern SaaS feel.

- **Buttons:** Fully rounded (pill-shaped) to distinguish them clearly from informational cards.
- **Input Fields:** 8px radius to maintain a professional, structured appearance.
- **Cards:** 16px radius for a soft, premium aesthetic.

## Components

### Buttons
- **Primary:** Solid green (#16A34A) with white text. High-contrast, no gradients.
- **Secondary:** Slate (#1E293B) or outlined with a 2px stroke for less critical actions.
- **Targets:** All buttons must maintain a minimum height of 48px for easy interaction.

### Cards & Containers
- Cards use a 16px corner radius and the Level 1 shadow. 
- Padding inside cards should be generous (24px) to prevent data from feeling cramped.

### Input Fields
- Use "Filled" style with a bottom-only border or "Outlined" with a 1px neutral-gray stroke.
- Active states transition the border to Primary Green with a 2px stroke.

### Chips & Status Indicators
- Status chips for "Healthy," "Charging," or "Disconnected" should use a subtle background tint of the status color (e.g., light green background with dark green text) for high glanceability.

### Specialized Components
- **Battery Level Indicator:** A custom vertical or horizontal bar component using the primary green. Segmented bars are preferred to indicate discrete capacity steps.
- **Data Lists:** Use 1px soft-gray horizontal dividers with 16px vertical padding per row to ensure readability in data-heavy views.
