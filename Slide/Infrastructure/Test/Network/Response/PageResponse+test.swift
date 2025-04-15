extension PageResponse {
    static let testPage1 = PageResponse(
        id: 0,
        content: """
인간은 태어나는 순간부터 의미를 찾는 여정을 시작한다. "왜 사는가?"라는 물음은 단순한 궁금증을 넘어서, 삶의 방향을 결정짓는 나침반이 된다. 우리는 일상 속에서 사소한 행동 하나에도 의미를 부여하며 살아간다. 어떤 이는 가족을 위해, 또 어떤 이는 자신만의 성취를 위해 살아간다. 그러나 그 모든 의미는 본질적으로 '존재'라는 물음 앞에서 흔들리곤 한다.
""",
        page: 0
    )
    static let testPage2 = PageResponse(
        id: 1,
        content: """
삶의 의미를 찾으려는 시도는 때때로 고통스럽다. 우주는 침묵하고, 신은 불확실하며, 사회는 정답을 강요한다. 존재의 무게를 견디기 위해 우리는 철학, 종교, 예술에 기대어 자신만의 해석을 만들어낸다. 이 해석은 누구에게 강요받는 것이 아니라, 각자가 자신의 내면 깊은 곳에서 길어 올려야 하는 것이다. 그러므로 삶의 의미는 발견되는 것이 아니라 창조되는 것이다.
""",
        page: 1
    )
    static let testPage3 = PageResponse(
        id: 2,
        content: """
결국 중요한 것은, 우리가 어떤 의미를 선택하고 그것을 어떻게 살아내느냐에 달려 있다. 의미는 고정된 것이 아니라 유동적이며, 삶의 순간순간에 따라 재구성된다. 의미를 찾아 헤매는 그 여정 자체가 우리를 인간답게 만든다. 어쩌면 진짜 중요한 질문은 '삶의 의미가 무엇인가'가 아니라, '나는 어떤 의미를 만들고 싶은가'일지도 모른다.
""",
        page: 2
    )
}

extension [PageResponse] {
    // for testSlide1
    static var testPages1: [PageResponse] = [.testPage1, .testPage2, .testPage3]
}
