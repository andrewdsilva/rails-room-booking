import { Controller } from "@hotwired/stimulus";

import "easepick-datetime";
import "easepick-core";
import "easepick-base-plugin";
import "easepick-range-plugin";
import "easepick-lock-plugin";
import "dayjs";

export default class extends Controller {
  connect() {
    this.initDate();

    let bookedDates = this.bookedDates;

    this.picker = new easepick.create({
      lang: window.getLocale(),
      format: this.displayFormat,
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
      RangePlugin: {
        startDate: this.startDate.format(this.displayFormat),
        endDate: this.endDate.format(this.displayFormat),
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

    this.picker.on("select", () => { this.onSelect(); });
  }

  initDate() {
    if (!this.startInput.value || !this.endInput.value) {
      this.startDate = dayjs();
      this.endDate = dayjs().add(1, "day");

      this.startInput.value = this.startDate.format(this.outputFormat);
      this.endInput.value = this.endDate.format(this.outputFormat);
    }
  }

  onSelect() {
    this.startInput.value = dayjs(this.picker.getStartDate()).format(this.outputFormat);
    this.endInput.value = dayjs(this.picker.getEndDate()).format(this.outputFormat);
  }

  get bookedDates() {
    let dates = this.data.get("bookedDates");

    return (dates ? JSON.parse(dates) : []).map(d => {
      if (Array.isArray(d)) {
        const start = new Date(d[0]);
        const end = new Date(d[1]);
        return [start, end];
      }
    });
  }

  get input() {
    return this.element.querySelector(".datepicker");
  }

  get startInput() {
    return this.element.querySelector(".start_date");
  }

  get endInput() {
    return this.element.querySelector(".end_date");
  }

  get dayPrice() {
    return this.data.get("dayPrice");
  }

  get displayFormat() {
    return "DD MMM YYYY";
  }

  get outputFormat() {
    return "YYYY-MM-DD";
  }
}
