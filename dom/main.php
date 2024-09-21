<?php
abstract class EventTarget
{
    /** @var array<string,array<callable>> $listeners **/ 
    protected $listeners = [];
    public function addEventListener(
        string $type,
        callable $listener,
        bool|array $options=null)
    {
        $set = ['listener'=>$listener,'options'=>$options];
        if(isset($this->listeners[$type])) {
            $this->listeners[$type][] = $set;
        } else {
            $this->listeners[$type] = [$set];
        }
    }
}

abstract class Node extends EventTarget
{
    abstract protected function _createMethod();

    /** @var array<Element> $elements **/ 
    protected array $children = [];
    protected array $parents = [];
    protected ?string $_id = null;

    public function __construct(
        public ?Node $parent = null,
        string $fixedId = null,
        ) {
        $this->_id = $fixedId;
    }

    public function appendChild(
        Node $element
    ) {
        $element->_appendParent($this);
        $this->children[] = $element;
    }

    public function _hasChild(
    ) {
        return count($this->children)!==0;
    }

    public function _appendParent(
        Node $element
    ) {
        $this->parents[] = $element;
    }

    public function _id() {
        if($this->_id) {
            return $this->_id;
        }
        return "id".spl_object_id($this);
    }

    public function _compile() {
        $script = "";
        foreach($this->children as $child) {
            //echo "class:".get_class($child).",id:".$child->_id()."\n";
            //if($child->parent!==null) {
            //    $script .= $child->parent->_compile();
            //}
            $script .= "const ".$child->_id()." = document.".$child->_createMethod().";\n";
            if($child->_hasChild()) {
                $script .= $child->_compile();
            }
            $script .= $this->_id().".appendChild(".$child->_id().");\n";
        }
        return $script;
    }
}

class Element extends Node
{
    public function __construct(
        public string $type,
        ?Node $parent = null,
        string $fixedId = null,
        ) {
        parent::__construct($parent,$fixedId);
    }

    protected function _createMethod()
    {
        return 'createElement("'.$this->type.'")';
    }
}

class TextNode extends Node
{
    public function __construct(
        public string $text,
        public ?Node $parent = null,
        string $fixedId = null,
        ) {
        parent::__construct($parent,$fixedId);
    }

    protected function _createMethod()
    {
        return 'createTextNode("'.$this->text.'")';
    }
}


class RealDoc
{
    protected string $script = "";
    public Element $body;

    public function __construct() {
        $this->body = new Element("body",fixedId:"document.body");
    }

    public function run() : void {
        $script = $this->body->_compile();
        echo <<<EOT
        <!DOCTYPE html>
        <html lang="ja">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <script>
                    // この関数は文書が読み込まれた時に実行される
                    window.onload = () => {
                        // create a couple of elements in an otherwise empty HTML page
                        {$script}
                    };
                </script>
                <title>Dom Test</title>
            </head>
            <body></body>
        </html>
        EOT;        
        // const heading = document.createElement("h1");
        // const headingText = document.createTextNode("Big Head!");
        // heading.appendChild(headingText);
        // document.body.appendChild(heading);
    }
    
    public function createElement(string $type) : Element {
        return new Element($type);
    }
    public function createTextNode(string $text) : TextNode {
        return new TextNode($text);
    }
}

$document = new RealDoc();
$heading = $document->createElement("h1");
$headingText = $document->createTextNode("Big Head!");
$heading->appendChild($headingText);
$document->body->appendChild($heading);
$document->run();
