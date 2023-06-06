import { Controller } from "@hotwired/stimulus";

import "easepick-datetime";
import "easepick-core";
import "easepick-base-plugin";
import "easepick-range-plugin";
import "easepick-lock-plugin";

export default class extends Controller {
  connect() {
    let bookedDates = this.bookedDates;

    let picker = new easepick.create({
      lang: window.getLocale(),
      format: "DD MMM YYYY",
      element: this.input,
      css: [
        "https://cdn.jsdelivr.net/npm/@easepick/bundle@1.2.1/dist/index.css",
        "/assets/easepick.css",
      ],
      plugins: ["RangePlugin", "LockPlugin"],
      RangePlugin: {
        tooltipNumber(num) {
          return num - 1;
        },
        locale: {
          one: "night",
          other: "nights",
        },
      },
      LockPlugin: {
        minDate: new Date(),
        minDays: 2,
        inseparable: true,
        filter: (date, picked) => {
          if (picked.length === 1) {
            const incl = date.isBefore(picked[0]) ? "[)" : "(]";
            return !picked[0].isSame(date, "day") && date.inArray(bookedDates, incl);
          }
          return date.inArray(bookedDates, "[)");
        },
      },
    });
  }

  get bookedDates() {
    return (this.data.get("bookedDates") || []).map(d => {
      if (Array.isArray(d)) {
        const start = new DateTime(d[0], "YYYY-MM-DD");
        const end = new DateTime(d[1], "YYYY-MM-DD");
        return [start, end];
      }
      return new DateTime(d, "YYYY-MM-DD");
    });
  }

  get input() {
    return this.element.querySelector(".datepicker");
  }
}
