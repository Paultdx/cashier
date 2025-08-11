# frozen_string_literal: true

# Money gem configuration
Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.default_infinite_precision = true
