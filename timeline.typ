#import "@preview/cetz:0.3.4"

// These code are copied from `herodot:0.1.0`.
// #import "@preview/herodot:0.1.0": *

// event constructor function that returns a dictionary
// with the values named
#let event(
  title: "y2k",
  year: 2000,
  month: 0,
  day: 0,
  time-tag: none, // KEYNOTE: Accept "year", "month/day" and `none`.
) = {
  let a = (
    title: title,
    year: year,
    month: month,
    day: day,
    time-tag: time-tag,
  )

  return a
}

#let eventspan(
  title: "y2k",
  color: red,
  // fill: red,
  start-point: 2000,
  end-point: 2001,
  timeline-offset: 0.5,
  box-width: auto,
) = {
  let b = (
    title: title,
    color: color,
    start-point: start-point,
    end-point: end-point,
    timeline-offset: timeline-offset,
    box-width: box-width,
  )
  return b
}



#let eventlocation(
  start-year: 1,
  end-year: 3,
  event: (title: "y2k", year: 20, month: 2, day: 30),
) = {
  let yearfrac = event.year

  // if month is set add its fraction of
  // a year to the total yearfrac value
  if event.month != 0 or event.month != none {
    if event.month <= 12 and event.month > 0 {
      yearfrac += event.month / 12
    }
  }

  // if the day is set add its fraction of
  // a month to a year to the total yearfrac value
  if event.day != 0 or event.day != none {
    if event.day < 31 and event.day > 0 {
      yearfrac += (event.day / 31) / 12
    }
  }


  let loc
  if start-year > 0 {
    loc = (yearfrac - start-year) / (end-year - start-year)
  }

  if start-year == 0 {
    loc = yearfrac / end-year
  }

  if start-year < 0 {
    loc = ((yearfrac + -(start-year)) / (end-year + -(start-year)))
  }

  return loc
}


#let eventspanlocation(
  start-year: 1,
  end-year: 3,
  eventyear: 2,
) = {
  if start-year > 0 {
    // if the start year is positive
    // it is subtracted so that it
    // is offset back to the origin
    // point (0,0) used by the graphing
    // system
    let x-pos = ((eventyear - start-year) / (end-year - start-year))
    return x-pos
  }

  if start-year == 0 {
    if end-year >= eventyear {
      // set the location as an
      // absolute x value from origin (0,0)
      // by calculating the percentage
      // the eventyear is from end

      let x-pos = (eventyear / end-year)
      return x-pos
    }
  }
  if start-year < 0 {
    // off sets the event types by start year
    // as positive,
    // so that the graphing mechanism can
    // use the orgin point (0,0) in the canvas
    // Said differently, so that the startyear
    // represents the origin point for the
    // rest of the timeline.
    let x-pos = ((eventyear + -(start-year)) / (end-year + -(start-year)))
    return x-pos
  }
}



#let timeline(
  // core elements
  startyear: 0,
  endyear: 10,
  interval: 2,
  events: (
    // event(
    //   title: "Genesis",
    //   year: 2025,
    //   month: 7,
    //   day: 26)
  ),
  eventspans: (
    // eventspan(
    //   title:"Depression",
    //   color: blue,
    //   start-point: 400,
    //   end-point: 600,
    //   )
  ),
  // optional styling elements
  length-of-timeline: 14,
  linestroke: 0.3pt + black,
  spanheight: 0.5,
  spanheight-positive-y: 0,
  spanheight-negative-y: 0,
) = {
  cetz.canvas(
    // the canvas draw surface
    {
      import cetz.draw: *

      // position of main timeline begining and line end
      let timeline-startpoint = (0, 0)
      let timeline-endpoint = (length-of-timeline, 0)
      line(
        timeline-startpoint,
        timeline-endpoint,
        name: "Timespan",
        mark: (end: ">"),
        stroke: linestroke,
      )

      // content labels for the beginning and final year

      let startyear-distance-timeline = 0.5

      // if the startyear is more than 3 characters to display increase
      // the distance between the timeline and the content to make room
      // for it to render it

      if startyear > 99 or startyear < -9 {
        startyear-distance-timeline = 0.7
      }
      content(
        (timeline-startpoint.first() - startyear-distance-timeline, 0),
        // anchor: "east",
        padding: (
          rest: .1,
          // right: .6,
        ),
        [ #startyear ],
      )

      let endyear-distance-timeline = 0.5

      if endyear > 99 or endyear < -9 {
        endyear-distance-timeline = 0.7
      }
      content(
        (timeline-endpoint.first() + endyear-distance-timeline, 0),
        [ #endyear ],
      )


      // make the vertical marks for the interval markings
      let interval-year = startyear

      while interval-year < endyear {
        let posx = (
          timeline-endpoint.first()
            * eventspanlocation(
              start-year: startyear,
              end-year: endyear,
              eventyear: interval-year,
            )
        )

        // the line marking itself
        line(
          (posx, -0.1),
          (posx, 0.1),
          stroke: linestroke,
        )

        // year description marking
        if interval-year != startyear {
          if startyear <= 0 {
            content(
              (posx, -0.3),
              [#interval-year],
            )
          }

          if startyear > 0 {
            content(
              (posx, -0.3),
              [#interval-year],
            )
          }
        }
        interval-year = interval-year + interval
      }

      // draw singular events on the timeline
      if events.len() != 0 {
        for x in events {
          let event-pos = (
            timeline-endpoint.first()
              * eventlocation(
                start-year: startyear,
                end-year: endyear,
                event: x,
              ),
            0,
          )

          // line for vertical marking
          let line-pos1 = (event-pos.first(), 0.4)
          line(
            event-pos,
            line-pos1,
            stroke: linestroke,
          )

          // content descriptions for the year
          if x.time-tag != none {
            content(
              (event-pos.first(), 0.7),
              if x.time-tag == "year" {
                [ #x.year ]
              } else if x.time-tag == "month" {
                if x.month != 0 and x.month != none {
                  [ #x.month ]
                } else {
                  [ #x.year ]
                }
              } else if x.time-tag == "month/day" {
                if x.month != 0 and x.month != none and x.day != 0 and x.day != none {
                  [ #{ x.month }/#{ x.day } ]
                } else if x.month != 0 and x.month != none {
                  [ #x.month ]
                } else {
                  [ #x.year ]
                }
              } else {
                x.time-tag
              },
            )
          }

          content(
            (event-pos.first(), line-pos1.last() + 0.7),
            angle: 45deg,
            anchor: "base-west",
            [ #x.title ],
          )
        }
      }

      // drawing the events that span across time (eventspan)
      if eventspans.len() != 0 {
        for x in eventspans {
          let event-pos-x-0 = (
            timeline-endpoint.first()
              * eventspanlocation(
                start-year: startyear,
                end-year: endyear,
                eventyear: x.start-point,
              )
          )
          let event-pos-x-1 = (
            timeline-endpoint.first()
              * eventspanlocation(
                start-year: startyear,
                end-year: endyear,
                eventyear: x.end-point,
              )
          )

          let span-y-offset = spanheight
          if spanheight-negative-y == 0 and spanheight-positive-y == 0 {
            span-y-offset = spanheight

            // block of the event span
            rect(
              (
                event-pos-x-0,
                span-y-offset,
              ),
              (
                event-pos-x-1,
                -span-y-offset,
              ),
              fill: x.color.transparentize(70%),
              stroke: x.color.transparentize(70%),
              radius: 5pt,
            )
          }


          if spanheight-negative-y != 0 or spanheight-positive-y != 0 {
            // block of the event span
            rect(
              (
                event-pos-x-0,
                spanheight-positive-y,
              ),
              (
                event-pos-x-1,
                -spanheight-negative-y,
              ),
              fill: x.color.transparentize(70%),
              stroke: x.color.transparentize(70%),
              radius: 5pt,
            )
          }

          // content for event span
          content(
            // position , also pulls in the eventspans timeline offset variable (x.last)
            ((event-pos-x-1 + event-pos-x-0) / 2, -span-y-offset - x.timeline-offset),
            anchor: "mid",
            [
              #let titletxt = align(center, text(fill: x.color, x.title))
              #if x.box-width != auto {
                box(width: x.box-width, titletxt)
              } else {
                box(width: 1cm, titletxt) // default width
              }
            ],
          )
        }
      }
    },
  )
}


